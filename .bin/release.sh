#! /bin/bash
# A modification of Dean Clatworthy's deploy script as found here: https://github.com/deanc/wordpress-plugin-git-svn via
# Brent Shepherd's deploy script at https://github.com/thenbrent/multisite-user-management/blob/master/deploy.sh .
# The difference is that this script lives in the plugin's git repo & doesn't require an existing SVN repo.

# main config
PLUGINSLUG="missed-scheduled-posts-publisher"
CURRENTDIR=`pwd`
MAIN_PHP_FILE="plugin.php"
README_FILE="readme.txt"
SKIP_NPM=true
NPM_BUILD_DIR=assets/build;
SKIP_COMPOSER=true
HEADERS=("Requires at least" "Requires PHP" "Tested up to" "License")

# git config
GITPATH="$CURRENTDIR" # this file should be in the base of your git repository

# svn config
TMPPATH="$GITPATH/.tmp-svn" # path to a temp SVN repo. No trailing slash required and don't add trunk.
SVNURL="https://plugins.svn.wordpress.org/$PLUGINSLUG/" # Remote SVN repo on wordpress.org, with trailing slash

# Load variables from .env file
source .env

# Exit with a prompt if the SVN_USERNAME environment variable is not set.
if [[ -z "${SVN_USERNAME}" ]]; then
  echo "SVN_USERNAME is not set. Please set it in the .env file."
  exit 1
else
  SVNUSER="${SVN_USERNAME}"
fi

# Let's begin...
echo ".........................................."
echo
echo "Preparing to deploy wordpress plugin"
echo
echo ".........................................."
echo

# Check if subversion is installed before getting all worked up
if ! which svn >/dev/null; then
	echo "You'll need to install subversion before proceeding. Exiting....";
	exit 1;
fi

if [ ! -z "$(git status --porcelain)" ]; then
	echo "Git is dirty."
	exit 1
fi

# Only exit once all checks are complete.
EXIT_WITH_ONE=0
for HEADER in "${HEADERS[@]}"; do
	RM_VALUE=`grep "^[ 	\*]*${HEADER}[ 	\*]*:" ${README_FILE} | awk -F' ' '{print $NF}'`
	PHP_VALUE=`grep "^[ 	\*]*${HEADER}[ 	\*]*:" ${MAIN_PHP_FILE} | awk -F' ' '{print $NF}'`
	echo "Header: ${HEADER}"
	echo "readme file: ${RM_VALUE}"
	echo "php file: ${PHP_VALUE}"
	echo
	if [ "$RM_VALUE" != "$PHP_VALUE" ]; then
		EXIT_WITH_ONE=1
	fi;
done;
if [ $EXIT_WITH_ONE == 1 ]; then
	exit 1
fi


# Check version in readme.txt is the same as plugin file after translating both to unix line breaks to work around grep's failure to identify mac line breaks
RM_VALUE=`grep "^[ 	\*]*Stable tag[ 	\*]*:" ${README_FILE} | awk -F' ' '{print $NF}'`
PHP_VALUE=`grep "^[ 	\*]*Version[ 	\*]*:" ${MAIN_PHP_FILE} | awk -F' ' '{print $NF}'`
echo "Version number check"
echo "readme stable tag: ${RM_VALUE}"
echo "php file version: ${PHP_VALUE}"
echo
if [ "$RM_VALUE" != "$PHP_VALUE" ]; then
	exit 1
fi

echo
echo "Remove and recreate temp directory"
rm -rf $TMPPATH
mkdir -p "$TMPPATH/svn-checkout";

echo
echo "Creating local copy of SVN repo ..."
svn co $SVNURL "$TMPPATH/svn-checkout"

echo
echo "Exporting archive of HEAD ..."
git archive --format zip -o "$TMPPATH/archive.zip" HEAD

echo
echo "Replacing SVN trunk with archive ..."
rm -rf "$TMPPATH/svn-checkout/trunk"
unzip "$TMPPATH/archive.zip" -d "$TMPPATH/svn-checkout/trunk"

cd "$TMPPATH/svn-checkout/trunk"

if [[ -f composer.json ]]; then
	if [[ false = $SKIP_COMPOSER ]]; then
		if ! which composer >/dev/null; then
			echo "You'll need to install composer before proceeding. Exiting....";
			exit 1;
		fi

		echo "Installing composer dependencies..."
		composer install --no-dev -a
	fi
	rm composer.{json,lock}
fi

if [[ -f package.json ]]; then
	if [[ false = $SKIP_NPM ]]; then
		if ! which npm >/dev/null; then
			echo "You'll need to install NPM before proceeding. Exiting....";
			exit 1;
		fi

		echo "Installing node dependencies..."
		npm install
		npm run build
		npm ci --production
		rm -rf node_modules/.*
	elif [ $NPM_BUILD_DIR ]; then
		cd $GITPATH;
		npm run build;
		mkdir -p "$TMPPATH/svn-checkout/trunk/$NPM_BUILD_DIR"
		cp -r "$GITPATH/$NPM_BUILD_DIR/" "$TMPPATH/svn-checkout/trunk/$NPM_BUILD_DIR/"
		cd "$TMPPATH/svn-checkout/trunk"
	fi
	rm package{.json,-lock.json}
fi

echo
echo "Removing dot files from root directory."
rm -rf .*

echo "Removing xml files from root directory."
rm *.xml
rm *.xml.dist

echo "Removing test files from root directory."
rm -rf tests

echo "Removing release documentation from root directory."
rm RELEASE.md

# echo "Removing webpack and remaining config files from root directory."
# rm webpack.config.js postcss.config.js

# echo
# echo "Removing asset src files from package."
# rm -rf assets/src

echo
echo "Initial SVN status"
svn status

echo
echo
echo "Preparing commit ..."
svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
svn status | grep -v "^.[ \t]*\..*" | grep "^\!" | awk '{print $2}' | xargs svn rm

if [[ -d "$TMPPATH/svn-checkout/tags/$RM_VALUE" ]]; then
	echo "Tag exists, updating readme only..."
	cp "$TMPPATH/svn-checkout/trunk/readme.txt" "$TMPPATH/svn-checkout/tags/$RM_VALUE/readme.txt"
else
	echo "Creating new tag..."
	cd "$TMPPATH/svn-checkout"
	svn copy trunk/ tags/$RM_VALUE
fi

echo
echo "Now ready to commit trunk ..."
cd "$TMPPATH/svn-checkout/"
svn status

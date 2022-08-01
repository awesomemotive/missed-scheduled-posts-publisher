# Releasing the plugin

This documentation describes how to release the plugin to WordPress.org.

## Preparing the release

### Update the version number

The plugin version number needs to be updated in the following files:

- [`plugin.php`](/plugin.php)
- [`readme.txt`](/readme.txt)

### Update the `tested up to` version

Before each release, a good practice is to test the plugin with the latest major version of WordPress. After testing, the `tested up to` version in the [`readme.txt`](/readme.txt) and [`plugin.php`](/plugin.php) files should be updated.
### Update the changelog

In the [`readme.txt`](/readme.txt) file, update the changelog for the new version.

### (_For the person releasing_) Make sure you have your SVN username in the `.env` file

The release script uses the SVN username to upload the plugin to WordPress.org. This username needs to have access to the plugin repository on WordPress.org SVN. The username needs to be set in the `.env` file as `SVN_USERNAME`.

## Publishing the release

### Run the release script

From the plugin root folder in your terminal, run the following command:

`bash .bin/release.sh`

This will run the release script and publish the new version to WordPress.org.

## Create a release tag and publish the release on GitHub

From GitHub UI, [create a new release tag for the plugin on GitHub](https://github.com/awesomemotive/missed-scheduled-posts-publisher/releases/new). The tag should be named `Version <version number>`. For example, `Version 1.0.0`.

Add the changelog from the [`readme.txt`](/readme.txt) file to the release description and create the release.

<?php
require '/wp-phpunit/includes/functions.php';

tests_add_filter( 'muplugins_loaded', function () {
	require dirname( __FILE__ ) . '/../plugin.php';
} );

require '/wp-phpunit/includes/bootstrap.php';

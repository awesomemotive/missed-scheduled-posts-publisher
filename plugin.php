<?php
/**
 * Plugin Name:       Missed Scheduled Posts Publisher
 * Description:       Catches scheduled posts that have been missed and publishes them.
 * Version:           1.0.0-beta
 * Requires at least: 5.0
 * Requires PHP:      5.6
 * Author:            WP Beginner
 * Author URI:        https://www.wpbeginner.com/
 * License:           GPLv2
 * Text Domain:       missed-scheduled-posts-publisher
 */
namespace WPB\MissedScheduledPostsPublisher;

require_once __DIR__ . '/inc/namespace.php';

bootstrap();

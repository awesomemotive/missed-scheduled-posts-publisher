# Missed Scheduled Posts Publisher

Stable tag: 1.0.0
Requires at least: 5.0
Tested up to:      5.6
Requires PHP:      5.6
License:           GPLv2
Tags:              Scheduled posts, Missed scheduled posts, Cron
Contributors:      WPbeginner, smub, jaredatch, peterwilsoncc

WordPress can sometimes fail to publish a scheduled post at the correct time. This monitors your site and publishes any that have missed their publication time.

== Description ==

This plugin does one thing and does it well: it ensures any scheduled (future) posts are published on time. The plugin has been developed with performance in mind so will not affect the perceived performance of your website.

Every fifteen minutes the plugin checks for posts that have missed their scheduled on time and will publish them. Multiple techniques for checking your site's missed posts are used to ensure a scheduled post is not missed.

= Credits =

This plugin is created by the [WPBeginner](https://www.wpbeginner.com/) team at [Awesome Motive](https://awesomemotive.com/).

To learn more about WordPress, you can visit [WPBeginner](https://www.wpbeginner.com/) for tutorials on topics like:

* [WordPress Speed and Performance](https://www.wpbeginner.com/wordpress-performance-speed/)
* [WordPress Security](https://www.wpbeginner.com/wordpress-security/)
* [WordPress SEO](https://www.wpbeginner.com/wordpress-seo/)

...and many more [WordPress tutorials](https://www.wpbeginner.com/category/wp-tutorials/).

If you find this plugin useful, please leave a good rating and consider checking out our other projects:

* [OptinMonster](https://optinmonster.com/) - Get More Email Subscribers
* [WPForms](https://wpforms.com/) - Best Contact Form Builder Plugin
* [MonsterInsights](https://www.monsterinsights.com/) - Best Google Analytics Plugin

== Installation ==

1. Install Insert Headers and Footers by uploading the `missed-scheduled-posts-publisher` directory to the `/wp-content/plugins/` directory. (See instructions on [how to install a WordPress plugin](https://www.wpbeginner.com/beginners-guide/step-by-step-guide-to-install-a-wordpress-plugin-for-beginners/).)
2. Activate Missed Scheduled Posts Publisher through the `Plugins` menu in WordPress.

[youtube https://www.youtube.com/watch?v=QXbrdVjWaME]

== Frequently Asked Questions ==

= My post was published late, why? =

To avoid impacting the performance of your WordPress site, this plugin checks for scheduled posts once every fifteen minutes. This is a compromise as avoiding a performance impact is important as the faster your site loads, the higher Google will rank it in organic search listings.

= I've enabled this on my site, why can't I see it in the admin? =

Missed Scheduled Posts Publisher is an enable and forget plugin. There is no user set up required so once the plugin is enabled, your site's scheduled posts will be checked.

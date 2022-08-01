<?php
/**
 * Class RunFrequencyFilter
 */

use function WPB\MissedScheduledPostsPublisher\get_run_frequency;

/**
 * Run frequency filter test
 */
class RunFrequencyFilter extends WP_UnitTestCase {

    public function test_run_frequency_should_be_the_default_value_if_no_filter_is_added() {
        $default_run_frequency = 900;
        $this->assertEquals( $default_run_frequency, get_run_frequency() );
    }

	public function test_run_frequency_should_be_the_one_set_by_filter() {
        add_filter( 'wpb_missed_scheduled_posts_publisher_frequency', function( $frequency ) {
            $frequency = 300;
            return $frequency;
        });
        
        $this->assertEquals( 300, get_run_frequency() );
    }

    public function test_run_frequency_should_be_an_integer() {
        add_filter( 'wpb_missed_scheduled_posts_publisher_frequency', function( $frequency ) {
            $frequency = 300.75;
            return $frequency;
        });
    
        $this->assertEquals( 300, get_run_frequency() );
    }
}

<?php
/**
 * Class RunFrequencyFilter
 *
 * @package Missed_Scheduled_Posts_Publisher
 */

/**
 * Run frequency filter test
 */
class RunFrequencyFilter extends WP_UnitTestCase {

	public function test_get_run_frequency() {


        add_filter( 'wpb_missed_scheduled_posts_publisher_frequency', function( $frequency ) {
            $frequency = 300;
            return $frequency;
        });


		$test = get_run_frequency();


        $this->assertEquals( 300, $test );
    }
}

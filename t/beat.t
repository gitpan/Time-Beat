#!/usr/bin/perl -w

use strict;
use Test::More tests => 8;

use Time::Beat qw( beats time12 time24 );

{
    is( time24( 0 ) => '23:00:00', 'Beat 0 is 11pm GMT' );
    is( time24( 500 ) => '11:00:00', 'Beat 500 is 11am GMT' );
    is( beats( 1060815600 ) => '0', '11pm GMT is beat 0' );
    is( beats( 1060862400 ) => '541', 'Noon GMT is beat 541' );
}

{
    is( time24( 348 ) => '07:21:07', 'Beat 348 is 7.21am GMT' );
    is( time12( 348 ) => '7:21:07 am', 'Beat 348 is 7.21am GMT' );
    is( time12( 648 ) => '2:33:07 pm', 'Beat 348 is 7.21am GMT' );
    is( beats( 1060845686 ) => '348', '7.21am GMT is beat 348' );
}


#!/usr/bin/perl -w
use strict;
use Test::More tests => 8;

use Time::Beat qw( beattime timebeat12 timebeat24 );

{
    is( timebeat24( 0 ) => '23:00:00', 'Beat 0 is 11pm, GMT' );
    is( timebeat24( 500 ) => '11:00:00', 'Beat 500 is 11am, GMT' );
    is( beattime( 1060815600 ) => '0', '11pm, GMT is beat 0' );
    is( beattime( 1060862400 ) => '541', 'noon, GMT is beat 541' );
}

{
    is( timebeat24( 348 ) => '07:21:07', 'Beat 348 is 7.21am, GMT' );
    is( timebeat12( 348 ) => '7:21:07 am', 'Beat 348 is 7.21am, GMT' );
    is( timebeat12( 648 ) => '2:33:07 pm', 'Beat 348 is 7.21am, GMT' );
    is( beattime( 1060845686 ) => '348', '7.21am GMT is 348m' );
}


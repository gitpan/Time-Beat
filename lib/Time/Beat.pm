package Time::Beat;

use strict;
use vars qw ( $VERSION @EXPORT_OK );

$VERSION = '1.21';

use Carp qw( croak );
use Exporter;

use base qw ( Exporter );
@EXPORT_OK = qw ( beats time24 time12 beattime timebeat24 timebeat12 );

# Note that the beattime, timebeat12 and timebeat24 methods are deprecated - see below.

sub beats {

    my $time = shift || time();

    unless ( $time =~ /^\d+$/ ) {
        croak "You can only use the 'beats' method with a number in the time() format."
    }

    return sprintf "%d", ( ( $time+3600 ) % 86400 ) / 86.4;
}

sub _beats_to_time {

    my $beat = shift;

    my $totalsecs = ( $beat * 86.4 );
    my $totalmins = int( $totalsecs / 60 );
    my $hours     = int( $totalmins / 60 );
    my $mins      = ( $totalmins % 60 );
    my $secs      = ( ( $totalsecs % 3600 ) % 60 );
    $hours--;
    $hours = 23 if $hours < 0;
    return ( $hours, $mins, $secs );
}

sub time24 {

    my $beat = shift;

    unless ( $beat =~ /^\d+$/ and $beat >= 000 and $beat <= 999 ) {
        return "You can only use the 'time24' method with a number in the range 000-999."
    }

    return sprintf "%02d:%02d:%02d", _beats_to_time( $beat );
}

sub time12 {

    my $beat = shift;

    unless ( $beat =~ /^\d+$/ && $beat >= 000 and $beat <= 999 ) {
        return "You can only use the 'time12' method with a number in the range 000-999."
    }

    my ( $hours, $mins, $secs ) = _beats_to_time( $beat );

    my $meridiem = ( $hours >= 12 ) ? "pm" : "am";
    $hours = $hours - 12 if $hours > 12;

    return sprintf "%d:%02d:%02d %s", $hours, $mins, $secs, $meridiem;
}

# DEPRECATED METHODS 
# These will be removed in the future.

sub beattime {
    my $time = shift || time();
    beats($time);
}

sub timebeat12 {
    my $beat = shift;
    time12($beat);
}

sub timebeat24 {
    my $beat = shift;
    time24($beat);
}

1;

__END__

=head1 NAME

Time::Beat - Module to convert between standard time and Swatch ".beat" time.

=head1 DESCRIPTION

C<Time::Beat> is a module to convert normal time to and from .beats, of
which there are a thousand in a day. It can change normal time in time() format 
to .beats, and .beats into either 24-hour or 12-hour normal time.

=head1 SYNOPSIS

    use Time::Beat qw(beat time24 time12);

    my $time_in_beats = beats($time);

    my $beats_in_24hr_time = time24($beat);

    my $beats_in_12hr_time = time12($beat);

=head1 METHODS

There are three methods in Time::Beat.

=over 4

=item * B<beats($time)>

C<beats> will give you the current time in .beats if you do not specify a
time string. If you specify a string in C<time()> format it will return that
particular time in .beats. The basic algorithm for doing this is to take 
the time in GMT+1 hour, convert it into seconds, and divide by 86.4.

=item * B<time24($beat)>

C<time24> takes a 3-digit beat time and outputs a 24-hour time along the
lines of "12:34:56". The hours will have leading noughts.

=item * B<time12($beat)>

C<time12> takes a 3-digit beat time and outputs a 12-hour time along the
lines of "12:34:56 am" or "12:34:56 pm". Hours do not have leading noughts.

=back

=head1 CHANGES

I<Important:> As of v1.11 the method names have changed. The former method
names, C<beattime>, C<timebeat24> and C<timebeat12> will still work, but they
have been B<deprecated>, and will be removed at some point in the future.

=head1 AUTHOR

Earle Martin <emartin@cpan.org>. Originally written by James Duncan
<jduncan@fotango.com>.

=head1 LICENSE

This work is licensed under the Creative Commons Attribution-ShareAlike
License. To view a copy of this license, visit
L<http://creativecommons.org/licenses/by-sa/1.0/> or send a letter to Creative
Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA. 

=head1 SEE ALSO

=over 4

=item * L<DateTime::Format::IBeat>

This module by Iain Truskett <spoon@cpan.org> does much the same thing but
in an OO fashion, and is part of the L<DateTime> project; if you need
something more sophisticated, I would suggest you look into that. My thanks
also to Iain for contributing patches to this module. 

=item * The .beat home page

L<http://www.swatch.com/itime_tools/itime.php>

=cut

package Time::Beat;

use strict;
use vars qw ( $VERSION @EXPORT_OK );

$VERSION = '1.1';

use Exporter;

use base qw ( Exporter );
@EXPORT_OK = qw ( beattime timebeat24 timebeat12 );

sub beattime {
	my $time = shift || time();

        unless ($time =~ /^\d+$/ && (length($time) == 10)) {
                return "You can only use the beattime method with a number in the time() format."
        }

	my $hsecs;

	my ($sec, $min, $hour, $mday, $mon, $year, $yday, $isdst) =
		gmtime($time);

	if ($hour != 23) {
  	  $hsecs = (($hour + 1) * 60) * 60;	
	}
	$hsecs += ($min * 60);
	$hsecs += $sec;
	return sprintf("%i", $hsecs / 86.4);
}

sub timebeat24 {
	my $beat = shift;
	
	unless ($beat =~ /^\d+$/ && $beat >= 000 && $beat <= 999) {
		return "You can only use the timebeat24 method with a number in the range 000-999."
	}

	my $totalsecs = ($beat * 86.4);
	my $totalmins = sprintf("%i", $totalsecs / 60);
	my $hours = sprintf("%i", $totalmins / 60);
	my $mins = ($totalmins % 60);
	my $secs = (($totalsecs % 3600) % 60);

	if (length($mins) == 1) {
		$mins = "0". $mins;
	}

	if (length($secs) == 1) {
		$secs = "0". $secs;
	}

	return "$hours:$mins:$secs";
}

sub timebeat12 {
	my $beat = shift;

	unless ($beat =~ /^\d+$/ && $beat >= 000 && $beat <= 999) {
		return "You can only use the timebeat12 method with a number in the range 000-999."
	}

	my $totalsecs = ($beat * 86.4);
	my $totalmins = sprintf("%i", $totalsecs / 60);
	my $hours = sprintf("%i", $totalmins / 60);
	my $mins = ($totalmins % 60);
	my $secs = (($totalsecs % 3600) % 60);

	if (length($mins) == 1) {
		$mins = "0". $mins;
	}

	if (length($secs) == 1) {
		$secs = "0". $secs;
	}

	my $meridiem = "am";

	if ($hours > 12) {
		$hours = $hours - 12;
		$meridiem = "pm";
	}

	# special case for midday
	if ($hours == 12 && $mins == 0) {
		$meridiem = "pm";
	}

	return "$hours:$mins:$secs $meridiem";
}

1;

__END__

=head1 NAME

Time::Beat - Module to convert between standard time and Swatch ".beat" time.

=head1 SYNOPSIS

use Time::Beat qw(beattime timebeat24 timebeat12);

my $time_in_beats = beattime(time());

my $beats_in_24hr_time = timebeat24($beat);

my $beats_in_12hr_time = timebeat12($beat);

=head1 DESCRIPTION

C<Time::Beat> is a module to convert normal time to and from .beats, of
which there are a thousand in a day. It can change normal time in time() format 
to .beats, and .beats into either 24-hour or 12-hour normal time.

=head1 METHODS

There are three methods in Time::Beat.

=over 4

=item beattime [time string]

C<beattime> will give you the current time in .beats if you do not specify a
time string. If you specify a string in C<time()> format it will return that
particular time in .beats. The basic algorithm for doing this is to take 
the time in GMT+1 hour, convert it into seconds, and divide by 86.4.

=item timebeat24 [beat string]

C<timebeat24> takes a 3-digit beat time and outputs a 24-hour time along the
lines of "12:34:56".

=item timebeat12 [beat string]

C<timebeat12> takes a 3-digit beat time and outputs a 12-hour time along the
lines of "12:34:56 am" or "12:34:56 pm".

=back

=head1 CHANGES

As of 1.1 the module can now convert to and from .beats in 12- and 24-hour
format.

=head1 AUTHOR

Earle Martin <emartin@cpan.org>. Originally written by James Duncan
<jduncan@fotango.com>.

=head1 SEE ALSO

L<DateTime::Format::IBeat>, which does much the same thing as part of the
DateTime project, and the .beat home page: 
L<http://www.swatch.com/itime_tools/itime.php>

=cut


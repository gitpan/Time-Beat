package Time::Beat;

# Module to use the new Swatch Internet time.

use strict;
use vars qw ( $VERSION @ISA @EXPORT );

$VERSION = '1.00';

use Exporter;
@ISA    = qw ( Exporter );
@EXPORT = qw ( beattime );

sub beattime {
	my $time = shift || time();
	my $hsecs;

	my ($sec, $min, $hour, $mday, $mon, $year, $yday, $isdst) =
		gmtime($time);

	$hsecs = (($hour + 1) * 60) * 60;	
	$hsecs += ($min * 60);
	$hsecs += $sec;
	return sprintf("%i", $hsecs / 86.4);
}



1;

__END__

=head1 NAME

Time::Beat - Module to convert from standard time to swatch 'beat' time.

=head1 SYNOPSIS

use Time::Beat;

my $time_in_beats = beattime(time());

=head1 DESCRIPTION

C<Time::Beat> is a module to provide you with the time in beats.  It takes
a C<time()> formatted string, and outputs the time in beats.  The basic
algorithm for doing this is to take time in GMT+1 hour, convert it into
seconds, and divide by 86.4.  Hopefully I'll get it converting backwards
at some point.

=head1 FUNCTIONS

=over 4

=item beattime [time string]

C<beattime> is the one and only function in Time::Beat.  It will give you
the current time in beats if you do not specify a time string.  If you
specify a time string it will return that particular time in beats.

=back

=head1 BUGS

James A. Duncan <jduncan@hawk.igs.net>

=head1 SEE ALSO

perl(1)

=cut


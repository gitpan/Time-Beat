use Test;

BEGIN { plan tests => 3 }

use Time::Beat qw(beattime timebeat12 timebeat24);

$a = beattime(1060780770);
$b = timebeat12(596);
$c = timebeat24(596);

ok( $a, '596' ); 		# converts from time() format to beats OK
ok( $b, '2:18:14 pm' );		# converts from beats to 12hr time OK
ok( $c, '14:18:14' );		# converts from beats to 24hr time OK
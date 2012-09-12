use strict;
use warnings;

use Funny::Web;

my $app = Funny::Web->apply_default_middlewares(Funny::Web->psgi_app);
$app;


use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use Governance::Engine;

my $app = Governance::Engine->apply_default_middlewares(Governance::Engine->psgi_app);
$app;


use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Governance::Engine';
use Governance::Engine::Controller::Issue;

ok( request('/issue')->is_success, 'Request should succeed' );
done_testing();

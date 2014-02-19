use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Governance::Engine';
use Governance::Engine::Controller::User;

ok( request('/user')->is_success, 'Request should succeed' );
done_testing();

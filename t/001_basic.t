#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Plack::Middleware::Authen');
    use_ok('Plack::Middleware::Authen::Agent');
    use_ok('Plack::Middleware::Authen::Identity');
    use_ok('Plack::Middleware::Authen::Identity::Store');
}

my @identities = (
    Plack::Middleware::Authen::Identity->new( id => 'stevan',   passphrase => 'secret' ),
    Plack::Middleware::Authen::Identity->new( id => 'perigrin', passphrase => 's3cr3t' ),
    Plack::Middleware::Authen::Identity->new( id => 'yuval',    passphrase => 'SuPeRsEkRiT' ),
);

my $authen = Plack::Middleware::Authen->new(
    store => Plack::Middleware::Authen::Identity::Store->new(
        hmac_key   => 'shhhdonttellanyone',
        identities => \@identities
    )
);
isa_ok($authen, 'Plack::Middleware::Authen');

# Authenticate from username/password

my $agent = $authen->authenticate( id => 'stevan', passphrase => 'secret' );
isa_ok($agent, 'Plack::Middleware::Authen::Agent');

ok( $agent->token, '... got a token for my agent' );
like( $agent->token, qr/[a-z0-9]+/, '... got a token in the right format' );

is( $agent->identity, $identities[0], '... got the correct identity');

## Re-Authenticate from a session or something

my $agent2 = $authen->re_authenticate( $agent->token );
isa_ok($agent2, 'Plack::Middleware::Authen::Agent');

is( $agent2->token, $agent->token, '... got the same token' );
is( $agent2->identity, $identities[0], '... got the correct identity');


done_testing;


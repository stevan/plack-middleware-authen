#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( $_ )
        for qw[
            Plack::Middleware::Authen
            Plack::Middleware::Authen::Identity
            Plack::Middleware::Authen::Identity::Store
        ];
}

done_testing;
package Plack::Middleware::Authen::Identity::Store;

use strict;
use warnings;

use Digest::HMAC_SHA1 qw[ hmac_sha1_hex ];

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use Plack::Util::Accessor qw[
    identities
    hmac_key
];

sub new {
    my ($class, %params) = @_;
    bless { %params } => $class;
}

sub find_identity_by_id {
    my ($self, $id) = @_;
    foreach my $identity ( @{ $self->identities } ) {
        return $identity
            if $identity->id eq $id;
    }
}

sub find_identity_by_token {
    my ($self, $token) = @_;
    foreach my $identity ( @{ $self->identities } ) {
        return $identity
            if $self->generate_token( $identity ) eq $token;
    }
}

sub generate_token {
    my ($self, $identity) = @_;
    hmac_sha1_hex( $identity->id, $self->hmac_key )
}

1;

__END__

=pod

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

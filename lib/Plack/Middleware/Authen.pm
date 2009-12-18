package Plack::Middleware::Authen;
use strict;
use warnings;

use Plack::Middleware::Authen::Agent;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use Plack::Util::Accessor qw[ store ];

sub new {
    my ($class, %params) = @_;
    bless { %params } => $class;
}

sub authenticate {
    my ($self, $id, $passphrase) = @_;
    if ( my $identity = $self->store->find_identity_by_id( $id ) ) {
        return Plack::Middleware::Authen::Agent->new(
            token    => $self->store->generate_token( $identity ),
            identity => $identity
        ) if $identity->verify_passphrase( $passphrase );
    }
}

sub re_authenticate {
    my ($self, $token) = @_;
    if ( my $identity = $self->store->find_identity_by_token( $token ) ) {
        return Plack::Middleware::Authen::Agent->new(
            token    => $token,
            identity => $identity
        )
    }
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

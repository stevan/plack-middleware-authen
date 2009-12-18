package Plack::Middleware::Authen::Identity;

use strict;
use warnings;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use Plack::Util::Accessor qw[ id passphrase user ];

sub new {
    my ($class, %params) = @_;
    bless { %params } => $class;
}

sub verify_passphrase {
    my ($self, $passphrase) = @_;
    $self->passphrase eq $passphrase
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

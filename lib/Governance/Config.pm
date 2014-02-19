package Governance::Config;
use MooseX::Singleton;
our $VERSION = '0.01';

use YAML::XS 0.39;

my $CONFIG = $ENV{Governance_CONFIG} || "/etc/governance/config.yml";

=head1 NAME

Governance::Config

=head1 SYNOPSIS

  use Governance::Config;
  my $value = Governance::Config->get('parameter');

=head1 DESCRIPTION

This module provides easy access to configuration parameters. It automatically
loads configuration from /etc/governance/config.yml and allows to access it via I<get>
method. You can change location of configuration file by setting Governance_CONFIG
environment variable.

=head1 METHODS

=cut

has _config => ( is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_config', );

sub _build_config {
    my $self = shift;
    die "Can't read config file $CONFIG" unless -r $CONFIG;
    my $res = YAML::XS::LoadFile($CONFIG);
    die "Configuration file $CONFIG is broken" unless ref $res eq 'HASH';
    return $res;
}

=head2 $self->get($name)

Returns value for parameter with given name.

=cut

sub get {
    my ( $self, $key ) = @_;
    return $self->_config->{$key};
}

no Moose;

1;

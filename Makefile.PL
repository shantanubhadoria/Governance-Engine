#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Governance-Engine';
all_from 'lib/Governance/Engine.pm';

requires 'Catalyst::Runtime' => '5.90007';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                            # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'DBIx::Class'                                    => '0.08270';
requires 'DBIx::Class::InflateColumn::Authen::Passphrase' => '0.01';
requires 'DBIx::Class::Validation'                        => '0.02005';
requires 'DBIx::Class::PassphraseColumn'                  => '0.02';
requires 'Log::Log4perl::Catalyst'                        => '1.42';
requires 'Catalyst::Helper::Model::DBIC::Schema'          => '0.62';

test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;

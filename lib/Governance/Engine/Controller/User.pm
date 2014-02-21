package Governance::Engine::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

Governance::Engine::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('user') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=head2 index

=cut

sub index :Chained('base') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Governance::Engine::Controller::User in User.');
}

=head2 add

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;

    if ( $form->submitted_and_valid ) {
        my $user = $c->model('DBIC::User')->new_result({});
        $form->model->update($user);
        $c->stash(
            json => {
                success        => 1,
                status_message => 'Registration Successful',
            },
        );
        $c->detach;
    } else {
        $c->stash(
            json => {
                success        => 0,
                status_message => 'Registration Failed',
            },
        );
    }
}

=head2 roles

=cut

sub roles :Chained('base') :PathPart('roles') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $c->check_user_roles('admin') ) {
        if ( $form->submitted_and_valid ) {
            my $user_role_map = $c->model('DBIC::UserRoleMap')->new_result({});
            $form->model->update($user_role_map);
            $c->response->redirect($c->uri_for($self->action_for('roles'),
                    {mid => $c->set_status_msg("Role Added")}));
            $c->detach;
        } else {
            $c->assets->include("css/form.css");
            $c->assets->include("js/form.js");
        }
    } else {
        $c->response->redirect($c->uri_for($self->action_for('login'),
                {mid => $c->set_status_msg("Insufficient Privileges")}));
    }
}

=head2 login

=cut

sub login :Chained('base') :PathPart('login') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;
    
    if ( $form->submitted_and_valid ) {
        if (
            ### authentication succeeded.
            $c->authenticate({
                    username => $c->req->params->{'username'},
                    password => $c->req->params->{'password'}
                }) 
        )
        {
            $c->log->debug("*** Authenticated User ***");
            $c->stash(
                json => {
                    success        => 1,
                    status_message => 'Authentication Successful',
                },
            );
        } else {
            ### authentication failed.
            $c->log->debug("*** Authentication Failed ***");
            $c->stash(
                json => {
                    success        => 0,
                    status_message => 'Authentication Failed',
                },
            );
        }
        $c->detach;
    } else {
        $c->stash(
            json => {
                success        => 0,
                status_message => 'Invalid Parameters',
            },
        );
    }
}

=head2 logout

=cut

sub logout :Chained('base') :PathPart('logout') :Args(0) {
    my ( $self, $c ) = @_;
    $c->logout();
    $c->stash(
        json => {
            success        => 1,
            status_message => 'Logged Out',
        },
    );
}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

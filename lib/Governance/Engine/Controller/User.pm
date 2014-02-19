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
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Governance::Engine::Controller::User in User.');
}

=head2 add

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    $c->stash(
    );

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;

    if ( $form->submitted_and_valid ) {
        my $user = $c->model('DBIC::User')->new_result({});
        $form->model->update($user);
        $c->stash(
            status_message => 'Registration Successful',
        );
        $c->detach;
    } else {
        $c->stash(
            status_message => 'Registration Failed',
        );
    }
}

=head2 login

=cut

sub login :Chained('base') :PathPart('login') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;
}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

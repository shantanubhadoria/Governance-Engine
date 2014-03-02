package Governance::Engine::Controller::Issue;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Governance::Engine::Controller::Issue - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

=cut

sub base :Chained('/base') :PathPart('issue') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=head2 list 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;
    my $issues = $c->model('DBIC::Issue')->search(
        undef,
        {
            select => [
                "me.id",
                "me.subject",
                "me.description",
                { date => "me.created_time"},

                "issue_type.name",

                "issue_status.name",

                "author_user.first_name",
                "author_user.middle_name",
                "author_user.last_name",
            ],
            join => [
                "issue_status",
                "author_user",
                "issue_type",
            ],
            order_by => {
                -desc => qw/me.id/,
            },
            page => $params->{page} || 1,
            rows => 10,
        },
    )->hashref_array;
    $c->stash->{json}->{issues} = $issues;
}

=head2 add

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    $form->stash->{context} = $c;

    if ( $form->submitted_and_valid ) {
        my $user = $c->model('DBIC::Issue')->new_result({});
        $form->add_valid(author_user_id=>$c->user->id);
        $form->model->update($user);
        $c->stash(
            json => {
                success        => JSON::true(),
                status_message => 'Issue Add',
            },
        );
        $c->detach;
    } else {
        $c->stash(
            json => {
                success        => JSON::false(),
                status_message => 'Issue Add Failed',
            },
        );
    }
}

=head1 AUTHOR

Shantanu Bhadoria,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

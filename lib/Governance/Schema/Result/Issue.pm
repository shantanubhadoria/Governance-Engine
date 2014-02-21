package Governance::Schema::Result::Issue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

Governance::Schema::Result::Issue

=cut

__PACKAGE__->table("issues");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 issue_type_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 author_user_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 subject

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 issue_status_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "issue_type_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "project_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "author_user_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "subject",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "issue_status_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 issue_status

Type: belongs_to

Related object: L<Governance::Schema::Result::IssueStatuse>

=cut

__PACKAGE__->belongs_to(
  "issue_status",
  "Governance::Schema::Result::IssueStatuse",
  { id => "issue_status_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 author_user

Type: belongs_to

Related object: L<Governance::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "author_user",
  "Governance::Schema::Result::User",
  { id => "author_user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 issue_type

Type: belongs_to

Related object: L<Governance::Schema::Result::IssueType>

=cut

__PACKAGE__->belongs_to(
  "issue_type",
  "Governance::Schema::Result::IssueType",
  { id => "issue_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2014-02-19 13:28:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:M+Cfa58zjY527bnGaOSiIg

__PACKAGE__->resultset_class( 'DBIx::Class::ResultSet::HashRef' );

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

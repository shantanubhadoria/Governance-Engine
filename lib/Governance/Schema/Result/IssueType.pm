package Governance::Schema::Result::IssueType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

Governance::Schema::Result::IssueType

=cut

__PACKAGE__->table("issue_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 ordering

  data_type: 'integer'
  extra: {unsigned => 1}
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
  "name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "ordering",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 issues

Type: has_many

Related object: L<Governance::Schema::Result::Issue>

=cut

__PACKAGE__->has_many(
  "issues",
  "Governance::Schema::Result::Issue",
  { "foreign.issue_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2014-02-19 13:28:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2ynxca29/NWwRfXO1CRkrA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

package Governance::Schema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

Governance::Schema::Result::Role

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 parent_role_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

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
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "parent_role_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 parent_role

Type: belongs_to

Related object: L<Governance::Schema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "parent_role",
  "Governance::Schema::Result::Role",
  { id => "parent_role_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 roles

Type: has_many

Related object: L<Governance::Schema::Result::Role>

=cut

__PACKAGE__->has_many(
  "roles",
  "Governance::Schema::Result::Role",
  { "foreign.parent_role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_role_maps

Type: has_many

Related object: L<Governance::Schema::Result::UserRoleMap>

=cut

__PACKAGE__->has_many(
  "user_role_maps",
  "Governance::Schema::Result::UserRoleMap",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2014-02-19 13:28:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qGKO6w5oLiScK1ohIuTftw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

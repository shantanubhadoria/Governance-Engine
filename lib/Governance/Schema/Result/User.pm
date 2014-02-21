package Governance::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn", "Validation");

=head1 NAME

Governance::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 middle_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 mobile_number

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "middle_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "mobile_number",
  { data_type => "varchar", is_nullable => 0, size => 45 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("email_UNIQUE", ["email"]);
__PACKAGE__->add_unique_constraint("username_UNIQUE", ["username"]);

=head1 RELATIONS

=head2 issues

Type: has_many

Related object: L<Governance::Schema::Result::Issue>

=cut

__PACKAGE__->has_many(
  "issues",
  "Governance::Schema::Result::Issue",
  { "foreign.author_user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_role_maps

Type: has_many

Related object: L<Governance::Schema::Result::UserRoleMap>

=cut

__PACKAGE__->has_many(
  "user_role_maps",
  "Governance::Schema::Result::UserRoleMap",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2014-02-19 22:16:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0pKM1Ph1pF8SZ5YmnmNzNg

__PACKAGE__->many_to_many(
  "roles" => 'user_role_maps',
  "role"
);

__PACKAGE__->add_columns(
  'password' => {
    passphrase       => 'rfc2307',
    passphrase_class => 'SaltedDigest',
    passphrase_args  => {
      algorithm   => 'SHA-1',
      salt_random => 20,
    },
    passphrase_check_method => 'check_password',
  },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

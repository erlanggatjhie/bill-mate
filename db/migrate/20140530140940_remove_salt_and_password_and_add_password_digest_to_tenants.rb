class RemoveSaltAndPasswordAndAddPasswordDigestToTenants < ActiveRecord::Migration
  def change
    remove_column :tenants, :password, :string
    remove_column :tenants, :salt, :string
    add_column :tenants, :password_digest, :string
  end
end

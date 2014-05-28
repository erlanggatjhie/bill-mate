class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end

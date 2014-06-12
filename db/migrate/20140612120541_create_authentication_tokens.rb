class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :token
      t.references :tenant, index: true
      t.integer :expires_in

      t.timestamps
    end
  end
end

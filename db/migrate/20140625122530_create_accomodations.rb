class CreateAccomodations < ActiveRecord::Migration
  def change
    create_table :accomodations do |t|
      t.string :address_line
      t.string :city
      t.string :postcode
      t.string :state

      t.timestamps
    end
  end
end

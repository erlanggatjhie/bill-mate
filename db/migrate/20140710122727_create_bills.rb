class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.date :due_date

      t.timestamps
    end
  end
end

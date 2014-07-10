class AddAccomodationToTenants < ActiveRecord::Migration
  def change
    add_reference :tenants, :accomodation, index: true
  end
end

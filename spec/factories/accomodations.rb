# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accomodation do
    address_line 'address line'
    city 'city'
    postcode '3000'
    state 'VIC'
  end
end

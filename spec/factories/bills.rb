# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    description "MyString"
    amount 9.99
    due_date Date.today + 1.day
  end
end

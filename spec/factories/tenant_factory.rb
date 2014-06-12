FactoryGirl.define do
  factory :tenant do
    first_name 'Erlangga'
    last_name 'tjhie'
    sequence(:email_address) {|n| "email#{n}@test.com" }
    password 'password'
    password_confirmation 'password'
  end
end
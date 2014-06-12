FactoryGirl.define do
  factory :authentication_token do
    token "thetoken"
    association :tenant, factory: :tenant
    expires_in 1
  end
end

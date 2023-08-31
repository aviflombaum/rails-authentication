FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person-#{n}@example.com" }

    password { "testpassword" }
    password_confirmation { "testpassword" }
  end
end

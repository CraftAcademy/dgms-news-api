FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    subscribed { false }
  end
end

FactoryBot.define do
    factory :external_identity do
      association :user
      provider { "SomeProvider" }
      uid { "SomeUID" }
    end
  end
  
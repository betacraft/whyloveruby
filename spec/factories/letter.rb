FactoryBot.define do
  factory :letter do
    association :user
    description { 'Ruby is Awesome' }
  end
end

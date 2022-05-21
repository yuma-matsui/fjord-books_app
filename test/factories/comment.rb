# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }

    trait :for_book do
      association :commentable, factory: :book
    end

    trait :for_report do
      association :commentable, factory: :report
    end
    association :user
  end
end

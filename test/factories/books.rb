# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    memo  { Faker::Lorem.sentence }
  end
end

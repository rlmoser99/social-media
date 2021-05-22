# frozen_string_literal: true

# == Schema Information
#
# Table name: friendship_requests
#
#  id                  :bigint           not null, primary key
#  status              :integer          default("pending")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  requested_friend_id :bigint
#  user_id             :bigint
#
FactoryBot.define do
  factory :friendship_request do
    user_id { "" }
    requested_friend_id { "" }
    status { 1 }

    trait :accepted do
      status { 2 }
    end

    trait :declined do
      status { 3 }
    end

    trait :blocked do
      status { 4 }
    end

    trait :with_two_users do
      association(:user, factory: :user)
      association(:requested_friend, factory: :user)
    end
  end
end

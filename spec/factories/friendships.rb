# frozen_string_literal: true

# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint
#  user_id    :bigint
#
FactoryBot.define do
  factory :friendship do
    user_id { "" }
    friend_id { "" }

    trait :with_two_users do
      association(:user, factory: :user)
      association(:friend, factory: :user)
    end
  end
end

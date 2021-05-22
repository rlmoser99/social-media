# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  notifiable_type :string
#  read_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint
#  recipient_id    :bigint
#
FactoryBot.define do
  factory :notification do
    recipient_id { "" }
    notifiable_id { "" }
    notifiable_type { "" }
    read_at { "2021-04-11 11:00:19" }

    trait :new do
      read_at { nil }
    end

    trait :with_friendship_request do
      association(:notifiable, factory: %i[friendship_request with_two_users])
      association(:recipient, factory: :user)
    end
  end
end

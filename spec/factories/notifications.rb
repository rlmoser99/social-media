# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                    :bigint           not null, primary key
#  read_at               :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  friendship_request_id :bigint
#  recipient_id          :bigint
#
FactoryBot.define do
  factory :notification do
    recipient_id { "" }
    friendship_request_id { "" }
    read_at { "2021-04-11 11:00:19" }

    trait :new do
      read_at { nil }
    end
  end
end

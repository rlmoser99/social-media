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
class FriendshipRequest < ApplicationRecord
  belongs_to :user
  belongs_to :requested_friend, class_name: 'User'

  enum status: {
    pending: 1,
    accepted: 2,
    declined: 3,
    blocked: 4
  }
end

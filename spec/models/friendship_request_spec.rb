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
require 'rails_helper'

RSpec.describe FriendshipRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

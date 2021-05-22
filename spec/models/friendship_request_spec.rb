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
  subject(:friendship_request) { create(:friendship_request, :with_two_users) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:requested_friend) }
  it { is_expected.to have_one(:notification) }
  it { is_expected.to define_enum_for(:status) }
end

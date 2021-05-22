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
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject(:friendship) { create(:friendship, :with_two_users) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }
end

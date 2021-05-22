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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { create(:notification, :with_friendship_request) }

  it { is_expected.to belong_to(:notifiable) }
  it { is_expected.to belong_to(:recipient) }
end

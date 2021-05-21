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
  # subject(:notification) { create(:notification) }

  # it { should belong_to(:notifiable) }
end

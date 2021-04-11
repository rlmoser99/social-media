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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

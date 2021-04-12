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
class Notification < ApplicationRecord
  belongs_to :friendship_request
  belongs_to :recipient, class_name: 'User'

  scope :unread, -> { where(read_at: nil) }
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint
#  commentable_id   :bigint
#
class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  delegated_type :commentable, types: %w[TextPost PhotoPost]
  has_one :notification, as: :notifiable, dependent: :destroy
end

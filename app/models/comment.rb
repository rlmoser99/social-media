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
  include ActionView::RecordIdentifier

  belongs_to :author, class_name: "User"
  delegated_type :commentable, types: %w[TextPost PhotoPost]
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  after_create_commit do
    broadcast_append_to [commentable, :comments], target: "#{dom_id(commentable)}_comments"
  end

  after_update_commit do
    broadcast_replace_to self
  end

  after_destroy_commit do
    broadcast_remove_to self
  end
end

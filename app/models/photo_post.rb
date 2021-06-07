# frozen_string_literal: true

# == Schema Information
#
# Table name: photo_posts
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  likes_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
class PhotoPost < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :author, class_name: "User"
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :image
  has_one :post, as: :postable, dependent: :destroy

  validates :image, presence: true

  after_update_commit { broadcast_replace_to self, target: dom_id(self).to_s }
  after_destroy_commit { broadcast_remove_to self }
end

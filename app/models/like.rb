# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :user, uniqueness: { scope: :post_id }
  validate :post_author_can_not_like

  private

    def post_author_can_not_like
      return unless user_id == post.author_id

      errors.add(:user, "can not like their own post.")
    end
end

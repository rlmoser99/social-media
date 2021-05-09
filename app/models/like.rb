# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_likes_on_user_id_and_likeable_id_and_likeable_type  (user_id,likeable_id,likeable_type) UNIQUE
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true
  validates :user, uniqueness: { scope: %i[likeable_id likeable_type] }
  validate :author_can_not_like

  private

    def author_can_not_like
      return unless user_id == likeable.author_id

      errors.add(:user, "can not like their own post.")
    end
end

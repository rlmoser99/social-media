# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  likeable_id   :bigint
#
# Indexes
#
#  index_likes_on_author_id_and_likeable_id_and_likeable_type  (author_id,likeable_id,likeable_type) UNIQUE
#
class Like < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :likeable, polymorphic: true, counter_cache: true
  validates :author, uniqueness: { scope: %i[likeable_id likeable_type] }
end

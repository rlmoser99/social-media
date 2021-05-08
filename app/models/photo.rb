# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
class Photo < ApplicationRecord
  belongs_to :author, class_name: "User", dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :image
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: text_posts
#
#  id          :bigint           not null, primary key
#  content     :text
#  likes_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
class TextPost < ApplicationRecord
  belongs_to :author, class_name: "User", dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :post, as: :postable, dependent: :destroy
end
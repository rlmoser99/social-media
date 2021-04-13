# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#  post_id    :bigint
#
class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", dependent: :destroy
  belongs_to :post
end

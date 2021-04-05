# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#
class Post < ApplicationRecord
  belongs_to :author, class_name: "User", dependent: :destroy
end

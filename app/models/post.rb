# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  postable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  postable_id   :bigint
#
class Post < ApplicationRecord
  delegated_type :postable, types: %w[TextPost PhotoPost]
  belongs_to :author, class_name: "User"
end

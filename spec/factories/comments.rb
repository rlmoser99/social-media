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
FactoryBot.define do
  factory :comment do
    content { "MyText" }
    commentable_id { "" }
    commentable_type { "" }
    author_id { "" }
  end
end

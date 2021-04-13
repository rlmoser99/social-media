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
FactoryBot.define do
  factory :comment do
    content { "MyText" }
    post_id { "" }
    author_id { "" }
  end
end

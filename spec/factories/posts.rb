# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  content     :text
#  likes_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
FactoryBot.define do
  factory :post do
    content { "MyText" }
    author_id { "" }
  end
end

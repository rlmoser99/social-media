# frozen_string_literal: true

# == Schema Information
#
# Table name: photo_posts
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  likes_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
FactoryBot.define do
  factory :photo_post do
    image { "MyString" }
    description { "MyText" }
    author_id { "" }
    post { association :post, postable: instance, author: author }
  end
end

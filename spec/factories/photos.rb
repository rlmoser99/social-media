# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
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
  factory :photo do
    image { "MyString" }
    description { "MyText" }
    author_id { "" }
  end
end

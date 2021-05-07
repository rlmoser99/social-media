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
FactoryBot.define do
  factory :photo do
    image { "MyString" }
    description { "MyText" }
    author_id { "" }
  end
end

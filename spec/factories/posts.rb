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
FactoryBot.define do
  factory :post do
    postable_id { "" }
    postable_type { "TextPost" }
    author_id { "" }
  end
end

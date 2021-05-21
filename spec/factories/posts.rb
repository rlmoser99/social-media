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
    association(:postable, factory: %i[text_post with_author])
    association(:author, factory: :user)
  end
end

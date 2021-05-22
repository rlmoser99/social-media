# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  likeable_id   :bigint
#
# Indexes
#
#  index_likes_on_author_id_and_likeable_id_and_likeable_type  (author_id,likeable_id,likeable_type) UNIQUE
#
FactoryBot.define do
  factory :like do
    author_id { "" }
    likeable_id { "" }
    likeable_type { "Post" }

    trait :with_post do
      association(:likeable, factory: %i[text_post with_author])
      association(:author, factory: :user)
    end
  end
end

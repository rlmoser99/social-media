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
    image { fixture_file_upload(Rails.root.join('spec/support/assets/picture.png'), 'image/png') }
    description { "MyText" }
    author_id { "" }
    post { association :post, postable: instance, author: author }

    trait :with_author do
      association(:author, factory: :user)
    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
FactoryBot.define do
  factory :like do
    user_id { "" }
    post_id { "" }
  end
end

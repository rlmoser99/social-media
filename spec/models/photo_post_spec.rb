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
require 'rails_helper'

RSpec.describe PhotoPost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: text_posts
#
#  id          :bigint           not null, primary key
#  content     :text
#  likes_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
require 'rails_helper'

RSpec.describe TextPost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

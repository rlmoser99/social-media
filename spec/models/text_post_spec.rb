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
  subject(:text_post) { create(:text_post, :with_author) }

  it { is_expected.to belong_to(:author) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_one(:post).dependent(:destroy) }
end

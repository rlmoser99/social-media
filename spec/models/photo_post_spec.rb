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
  subject(:photo_post) { create(:photo_post, :with_author) }

  it { is_expected.to belong_to(:author).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_one(:post).dependent(:destroy) }

  it "has an attached image" do
    expect(photo_post.image).to be_attached
  end
end

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
require 'rails_helper'

RSpec.describe Like, type: :model do
  context "when a user tries to like same post twice" do
    # 2 Users, 1 Post, 1 Like
    let!(:amy) { create(:user, first_name: 'Amy') }
    let!(:beth) { create(:user, first_name: 'Beth') }
    let!(:amy_post) { create(:text_post, author: amy) }
    let!(:beth_like) { create(:like, author: beth, likeable: amy_post) }

    it "raises an Invalid Record error" do
      expect { create(:like, author: beth, likeable: amy_post) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "when post author tries to like their post" do
    # 2 Users, 1 Post, 1 Like
    let!(:amy) { create(:user, first_name: 'Amy') }
    let!(:beth) { create(:user, first_name: 'Beth') }
    let!(:amy_post) { create(:text_post, author: amy) }

    it "raises an Invalid Record error" do
      expect { create(:like, author: amy, likeable: amy_post) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end

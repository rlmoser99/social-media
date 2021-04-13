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
require 'rails_helper'

RSpec.describe Like, type: :model do
  context "when a user tries to like same post twice" do
    # 2 Users, 1 Post, 1 Like
    let!(:amy) { create(:user, first_name: 'Amy') }
    let!(:beth) { create(:user, first_name: 'Beth') }
    let!(:amy_post) { create(:post, author: amy) }
    let!(:beth_like) { create(:like, user: beth, post: amy_post) }

    it "raises an Invalid Record error" do
      expect { create(:like, user: beth, post: amy_post) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "when post author tries to like their post" do
    # 2 Users, 1 Post, 1 Like
    let!(:amy) { create(:user, first_name: 'Amy') }
    let!(:beth) { create(:user, first_name: 'Beth') }
    let!(:amy_post) { create(:post, author: amy) }

    it "raises an Invalid Record error" do
      expect { create(:like, user: amy, post: amy_post) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end

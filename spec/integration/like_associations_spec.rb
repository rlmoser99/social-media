# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "like, post and user model associations" do
  # User
  let!(:amy) { create(:user) }
  let!(:beth) { create(:user) }

  # Post
  let!(:amy_post) { create(:post, author: amy) }

  # Like
  let!(:beth_like) { create(:like, post: amy_post, user: beth) }

  context 'post' do
    it "has one like" do
      expect(amy_post.likes).to include(beth_like)
    end
  end

  context 'user' do
    it "has one like" do
      expect(beth.likes).to include(beth_like)
    end
  end
end

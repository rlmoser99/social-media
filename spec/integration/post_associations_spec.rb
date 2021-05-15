# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "post and user model associations" do
  # User
  let!(:amy) { create(:user) }

  # Post
  let!(:amy_post) { create(:text_post, author: amy) }

  context 'user' do
    it "has one post" do
      expect(amy.text_posts).to include(amy_post)
    end
  end

  context 'post' do
    it "has one author" do
      expect(amy_post.author).to be(amy)
    end
  end
end

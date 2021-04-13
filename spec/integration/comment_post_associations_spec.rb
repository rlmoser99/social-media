# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "post and comment model associations" do
  # User
  let!(:amy) { create(:user) }
  let!(:beth) { create(:user) }

  # Post
  let!(:amy_post) { create(:post, author: amy) }

  # Comment
  let!(:beth_comment) { create(:comment, post: amy_post, author: beth) }

  context 'post' do
    it "has one comment" do
      expect(amy_post.comments).to include(beth_comment)
    end
  end

  context 'comment' do
    it "has one post" do
      expect(beth_comment.post).to be amy_post
    end
  end

  context 'user' do
    it "has one comment" do
      expect(beth.comments).to include(beth_comment)
    end
  end
end

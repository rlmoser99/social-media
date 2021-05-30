# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a comment", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:text_post) { create(:text_post, author: user) }
  let!(:comment) { create(:comment, commentable: text_post, author: user, content: "Sample Comment") }

  before do
    sign_in(user)
    visit(newsfeed_path)
  end

  it "successfully edits" do
    within '.comment-container' do
      expect(page).to have_content(comment.content)
    end

    within '.comment-author-actions' do
      page.click_link('', href: edit_comment_path(comment))
    end

    within find('.comment-form') do
      fill_in("comment[content]", with: "This is the edited comment.")
      find_submit_button.click
    end

    expect(find('.comment-content')).to have_content("This is the edited comment.")
  end

  it "successfully deletes" do
    within '.comment-author-actions' do
      page.click_link('', href: comment_path(comment))
    end

    expect(find('.post-container')).to have_no_css('.comment-container')
    expect(text_post.comments.count).to eq(0)
  end
end

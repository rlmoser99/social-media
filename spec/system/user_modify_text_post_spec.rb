# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a text post", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:text_post) { create(:text_post, author: user, content: "This is sample post content.") }

  context 'when user is the author of text post' do
    before do
      sign_in(user)
      visit(newsfeed_path)
    end

    it "successfully edits" do
      within '.post-container' do
        expect(page).to have_content(text_post.content)
      end

      within '.author-actions' do
        page.click_link('', href: edit_text_post_path(text_post))
      end

      within '.post-form' do
        fill_in("text_post[content]", with: "This is the edited content.")
        find_submit_button.click
      end

      expect(find('.post-content')).to have_content("This is the edited content.")
    end

    it "successfully deletes" do
      within '.author-actions' do
        page.click_link('', href: text_post_path(text_post))
      end

      expect(page).to have_no_css('.post-container')
      expect(user.text_posts.count).to eq(0)
    end
  end

  context 'when user is not the author of text post' do
    let!(:friend) { create(:user) }
    let!(:user_friend) { create(:friendship, user: user, friend: friend) }
    let!(:friend_user) { create(:friendship, user: friend, friend: user) }

    before do
      sign_in(friend)
      visit(newsfeed_path)
    end

    it "ignores edit request" do
      within '.post-container' do
        expect(page).to have_content(text_post.content)
      end

      within '.author-actions' do
        page.click_link('', href: edit_text_post_path(text_post))
      end

      within '.post-container' do
        expect(page).to have_content(text_post.content)
        expect(page).to have_no_css('text_area')
      end
    end

    it "ignores delete request" do
      within '.post-container' do
        expect(page).to have_content(text_post.content)
      end

      within '.author-actions' do
        page.click_link('', href: text_post_path(text_post))
      end

      within '.post-container' do
        expect(page).to have_content(text_post.content)
      end
      expect(user.text_posts.count).to eq(1)
    end
  end
end

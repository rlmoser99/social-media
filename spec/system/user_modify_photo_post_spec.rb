# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a photo post", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:photo_post) { create(:photo_post, author: user, description: "This is sample photo description.") }

  context 'when user is the author of text post' do
    before do
      sign_in(user)
      visit(newsfeed_path)
    end

    it "successfully edits" do
      within '.photo-container' do
        expect(page).to have_content(photo_post.description)
      end

      within '.author-actions' do
        page.click_link('', href: edit_photo_post_path(photo_post))
      end

      within '.photo-form' do
        fill_in("photo_post[description]", with: "This is the edited description.")
        find_submit_button.click
      end

      expect(find('.photo-description')).to have_content("This is the edited description.")
    end

    it "successfully deletes" do
      within '.author-actions' do
        page.click_link('', href: photo_post_path(photo_post))
      end

      expect(page).to have_no_css('.photo-container')
      expect(user.photo_posts.count).to eq(0)
    end
  end

  context 'when user is not the author of photo post' do
    let!(:friend) { create(:user) }
    let!(:user_friend) { create(:friendship, user: user, friend: friend) }
    let!(:friend_user) { create(:friendship, user: friend, friend: user) }

    before do
      sign_in(friend)
      visit(newsfeed_path)
    end

    it "ignores edit request" do
      within '.photo-container' do
        expect(page).to have_content(photo_post.description)
      end

      within '.author-actions' do
        page.click_link('', href: edit_photo_post_path(photo_post))
      end

      within '.photo-container' do
        expect(page).to have_content(photo_post.description)
        expect(page).to have_no_css('text_area')
      end
    end

    it "ignores delete request" do
      within '.photo-container' do
        expect(page).to have_content(photo_post.description)
      end

      within '.author-actions' do
        page.click_link('', href: photo_post_path(photo_post))
      end

      within '.photo-container' do
        expect(page).to have_content(photo_post.description)
      end
      expect(user.photo_posts.count).to eq(1)
    end
  end
end

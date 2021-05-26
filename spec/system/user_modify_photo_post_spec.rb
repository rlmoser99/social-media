# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a photo post", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:photo_post) { create(:photo_post, author: user, description: "This is sample photo description.") }

  it "successfully edits and deletes" do
    sign_in(user)
    visit(newsfeed_path)

    within '.photo-container' do
      expect(page).to have_content(photo_post.description)
    end

    within '.author-actions' do
      expect(page).to have_link('', href: edit_photo_post_path(photo_post))
      expect(page).to have_link('', href: photo_post_path(photo_post))
    end

    within '.author-actions' do
      page.click_link('', href: edit_photo_post_path(photo_post))
    end

    expect(page).to have_current_path(edit_photo_post_path(photo_post))

    within '.photo-form' do
      fill_in("photo_post[description]", with: "This is the edited description.")
      find_submit_button.click
    end

    within '.photo-container' do
      expect(page).to have_no_content(photo_post.description)
      expect(page).to have_content("This is the edited description.")
    end

    within '.author-actions' do
      page.click_link('', href: photo_post_path(photo_post))
    end

    expect(page).to have_no_css('.photo-container')
    expect(page).to have_no_content("This is the edited description.")
  end
end

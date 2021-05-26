# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a text post", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:text_post) { create(:text_post, author: user, content: "This is sample post content.") }

  it "successfully edits and deletes" do
    sign_in(user)
    visit(newsfeed_path)

    within '.post-container' do
      expect(page).to have_content(text_post.content)
    end

    within '.author-actions' do
      expect(page).to have_link('', href: edit_text_post_path(text_post))
      expect(page).to have_link('', href: text_post_path(text_post))
    end

    within '.author-actions' do
      page.click_link('', href: edit_text_post_path(text_post))
    end

    expect(page).to have_current_path(edit_text_post_path(text_post))

    within '.post-form' do
      fill_in("text_post[content]", with: "This is the edited content.")
      find_submit_button.click
    end

    within '.post-container' do
      expect(page).to have_no_content(text_post.content)
      expect(page).to have_content("This is the edited content.")
    end

    within '.author-actions' do
      page.click_link('', href: text_post_path(text_post))
    end

    expect(page).to have_no_css('.post-container')
    expect(page).to have_no_content("This is the edited content.")
  end
end

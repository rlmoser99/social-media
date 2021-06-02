# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user modifies a text post", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:text_post) { create(:text_post, author: user, content: "This is sample post content.") }

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

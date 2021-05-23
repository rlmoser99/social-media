# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user creates a text post", type: :system do
  include CustomMatchers

  it "shows text post content" do
    sign_in(create(:user))
    visit(newsfeed_path)
    sample_post_content = "This is sample post content."
    within '.post-form' do
      fill_in("text_post[content]", with: sample_post_content)
      find_submit_button.click
    end

    within '.post-container' do
      expect(page).to have_content(sample_post_content)
    end
  end
end

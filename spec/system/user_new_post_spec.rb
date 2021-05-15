# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user creates a new post", type: :system do
  context "A user that is logged-in"

  it "creates a new post and can view it" do
    sign_in(create(:user))
    sample_post_content = "This is sample post content."
    visit(newsfeed_path)
    within '.post-form' do
      fill_in("text_post[content]", with: sample_post_content)
      find('button[type="submit"]').click
    end
    expect(page).to have_content(sample_post_content)
  end
end

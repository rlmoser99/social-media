# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user creates a new post", type: :system do
  context "A user that is logged-in"

  it "creates a new post and can view it" do
    sign_in(create(:user))
    sample_post_content = "This is sample post content."
    visit(posts_path)
    fill_in("post[content]", with: sample_post_content)
    click_on("Save Post")
    expect(page).to have_content(sample_post_content)
  end
end

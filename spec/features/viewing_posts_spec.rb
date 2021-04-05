# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Log in required to view posts" do
  let!(:user) { FactoryBot.create(:user) }

  context "User can see posts" do
    scenario "with valid credentials" do
      visit "/"
      click_link "Log In"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on("Log in")

      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Post Index"
    end
  end

  context "User can not see posts" do
    scenario "with invalid credentials" do
      visit "/"
      click_link "Log In"
      fill_in "Email", with: user.email
      fill_in "Password", with: "foo"
      click_on("Log in")

      expect(page).to have_content "Invalid Email or password."
      expect(page).not_to have_content "Post Index"
    end
  end
end

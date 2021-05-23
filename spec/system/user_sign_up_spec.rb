# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user sign up", type: :system do
  include CustomMatchers

  context 'with valid credentials' do
    it 'signs up successfully' do
      visit(new_user_registration_path)
      within 'form' do
        fill_in "First name", with: "Jubal"
        fill_in "Last name", with: "Early"
        fill_in "Email", with: "jubal@bountyhunter.gov"
        fill_in "Password", with: "alliance"
        fill_in "Password confirmation", with: "alliance"
        find_submit_btn.click
      end

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid credentials' do
    it 'shows error messages' do
      visit(new_user_registration_path)
      within 'form' do
        fill_in "First name", with: "Jubal"
        fill_in "Last name", with: "Early"
        fill_in "Email", with: "jubal@bountyhunter.gov"
        fill_in "Password", with: "alliance"
        fill_in "Password confirmation", with: "federation"
        find_submit_btn.click
      end

      expect(page).to have_content(/prohibited this user from being saved./)
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_current_path(users_path)
    end
  end

  context 'with facebook oauth' do
    before do
      mock_oauth_provider(:facebook)
    end

    after do
      OmniAuth.config.mock_auth[:facebook] = nil
    end

    context 'providing valid credentials' do
      it 'signs up successfully' do
        visit(new_user_registration_path)
        click_on("Sign in with Facebook")

        expect(page).to have_current_path(root_path)
      end
    end

    context 'providing invalid credentials' do
      before do
        OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      end

      it 'redirects to new user sign up page' do
        visit(new_user_registration_path)
        click_on("Sign in with Facebook")

        expect(page).to have_content("You need to sign in or sign up before continuing.")
        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end
end

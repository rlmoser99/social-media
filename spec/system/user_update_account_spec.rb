# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user sign up", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }

  context 'with valid credentials' do
    it 'changes account information successfully' do
      sign_in(user)
      visit(user_path(user))
      click_on("Edit Account")

      expect(page).to have_current_path(edit_user_registration_path)

      new_email = "jubal@early.com"
      within 'form' do
        fill_in("user[email]", with: new_email)
        fill_in("user[current_password]", with: user.password)
        find_submit_btn.click
      end

      expect(page).to have_current_path(root_path)

      visit(user_path(user))

      expect(page).to have_content(new_email)
    end
  end

  context 'with invalid credentials' do
    it 'does not changes account information' do
      sign_in(user)
      visit(user_path(user))
      click_on("Edit Account")

      expect(page).to have_current_path(edit_user_registration_path)

      new_email = "jubal@early.com"
      within 'form' do
        fill_in("user[email]", with: new_email)
        fill_in("user[current_password]", with: 'invalid_password')
        find_submit_btn.click
      end

      expect(page).to have_content("1 error prohibited this user from being saved:")
      expect(page).to have_content("Current password is invalid")
    end
  end

  context 'with facebook oauth' do
    before do
      mock_oauth_provider(:facebook)
    end

    after do
      OmniAuth.config.mock_auth[:facebook] = nil
    end

    it 'changes account information successfully' do
      visit(new_user_registration_path)
      click_on("Sign in with Facebook")
      visit(edit_user_registration_path)
      new_email = "jubal@early.com"
      within '#edit_user' do
        fill_in("user[email]", with: new_email)
        find_submit_btn.click
      end

      expect(page).to have_current_path(root_path)
    end
  end
end

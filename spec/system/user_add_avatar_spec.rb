# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user can update their avatar", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }

  it "updates default material-icon to avatar img" do
    sign_in(user)
    visit(user_path(user))

    within '.avatar' do
      expect(page).to have_selector('span.material-icons')
      expect(page).to have_no_selector('img')
    end

    page.attach_file('user[avatar]', Rails.root.join('spec/support/assets/avatar.png'))
    find_submit_button.click

    within '.avatar' do
      expect(page).to have_selector('img')
      expect(page).to have_no_selector('span.material-icons')
    end
    expect(user.avatar.attached?).to be true
  end
end

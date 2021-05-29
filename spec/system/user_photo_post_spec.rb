# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user creates a text post", type: :system do
  include CustomMatchers

  context 'when attaching a file' do
    it "shows photo post and description" do
      sign_in(create(:user))
      visit(newsfeed_path)
      sample_post_description = "This is sample post description."
      within '.newsfeed-tabs' do
        find('label', text: 'Share a Photo').click
        fill_in("photo_post[description]", with: sample_post_description)
        page.attach_file('photo_post[image]', Rails.root.join('spec/support/assets/picture.png'))
        find_submit_button.click
      end

      within '.photo-container' do
        expect(page).to have_content(sample_post_description)
        expect(page).to have_css('img.photo-image')
      end
    end
  end

  context 'when not attaching a file' do
    it "shows error message" do
      sign_in(create(:user))
      visit(newsfeed_path)
      sample_post_description = "This is sample post description."
      within '.newsfeed-tabs' do
        find('label', text: 'Share a Photo').click
        fill_in("photo_post[description]", with: sample_post_description)
        find_submit_button.click

        message = page.find("input[type='file']").native.attribute("validationMessage")
        expect(message).to eq("Please select a file.")
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'instructions' do
    let(:user) { create(:user, first_name: "Jubal", last_name: "Early", email: "jubal@bountyhunter.gov") }
    let(:mail) { described_class.welcome_email(user).deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to rlmoser's social media!")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['OzarkBlueCatLodge@gmail.com'])
    end

    it "contains the user's first name" do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it "contains a link to the home page" do
      expect(mail.body.encoded)
        .to match(root_url.to_s)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  context 'when a new user is created' do
    it 'sends an email' do
      expect { create(:user) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end

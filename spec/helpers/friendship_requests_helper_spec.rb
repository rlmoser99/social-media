# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipRequestsHelper, type: :helper do
  describe '#humanize_status_label' do
    it 'humanizes accepted status for forms' do
      expect(helper.humanize_status_label[:pending]).to be nil
    end

    it 'humanizes accepted status for forms' do
      expect(helper.humanize_status_label[:accepted]).to eq("Accept")
    end

    it 'humanizes accepted status for forms' do
      expect(helper.humanize_status_label[:declined]).to eq("Decline")
    end

    it 'humanizes accepted status for forms' do
      expect(helper.humanize_status_label[:blocked]).to eq("Block")
    end
  end
end

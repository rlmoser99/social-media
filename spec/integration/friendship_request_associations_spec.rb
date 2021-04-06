# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "friendship request and user model associations" do
  # Users
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }

  # Friendship Request
  let!(:amy_beth) { create(:friendship_request, user: amy, requested_friend: beth) }

  context 'user and friendship requests' do
    describe '#friendship_requests' do
      it "has a friendship request" do
        expect(amy.friendship_requests).to include(amy_beth)
      end
    end

    describe '#requested_friendships' do
      it "has a requested friendship" do
        expect(beth.requested_friendships).to include(amy_beth)
      end
    end
  end
end

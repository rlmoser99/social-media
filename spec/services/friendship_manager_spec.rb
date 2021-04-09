# frozen_string_literal: true

require "rails_helper"

RSpec.describe FriendshipManager do
  # 2 Users & their Friendship Request
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }
  let!(:amy_beth) { create(:friendship_request, user: amy, requested_friend: beth) }

  context "when request status changes and friendship does not exist" do
    it "does not raise an error" do
      manager = FriendshipManager.new(amy_beth, "blocked")
      expect { manager.call }.not_to raise_error
    end
  end

  context "when request status changes" do
    before do
      manager = FriendshipManager.new(amy_beth, "accepted")
      manager.call
    end

    context 'when friendship request status is changed to accepted' do
      it "creates a friend for the user" do
        expect(amy.friends).to include(beth)
      end

      it "creates a friend for the requested friend" do
        expect(beth.friends).to include(amy)
      end
    end

    context 'when friendship request status is changed from accepted to declines' do
      before do
        second_manager = FriendshipManager.new(amy_beth, "declined")
        second_manager.call
      end

      it "removes a friend for the user" do
        expect(amy.friends).not_to include(beth)
      end

      it "removes a friend for the requested friend" do
        expect(beth.friends).not_to include(amy)
      end
    end

    context 'when friendship request status is changed from accepted to blocked' do
      before do
        second_manager = FriendshipManager.new(amy_beth, "blocked")
        second_manager.call
      end

      it "removes a friend for the user" do
        expect(amy.friends).not_to include(beth)
      end

      it "removes a friend for the requested friend" do
        expect(beth.friends).not_to include(amy)
      end
    end
  end
end

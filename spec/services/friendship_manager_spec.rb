# frozen_string_literal: true

require "rails_helper"

RSpec.describe FriendshipManager do
  # 2 Users & their Friendship Request
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }
  let!(:friendship_request) { create(:friendship_request, user: amy, requested_friend: beth) }

  context 'when friendship request status is accepted' do
    before do
      FriendshipManager.new(friendship_request, "accepted").call
    end

    it "creates a friend for the user" do
      expect(amy.friends).to include(beth)
    end

    it "creates a friend for the requested friend" do
      expect(beth.friends).to include(amy)
    end
  end

  context "when friendship exists" do
    context 'when friendship request status is changed from accepted to declines' do
      before do
        FriendshipManager.new(friendship_request, "accepted").call
        FriendshipManager.new(friendship_request, "declined").call
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
        FriendshipManager.new(friendship_request, "accepted").call
        FriendshipManager.new(friendship_request, "blocked").call
      end

      it "removes a friend for the user" do
        expect(amy.friends).not_to include(beth)
      end

      it "removes a friend for the requested friend" do
        expect(beth.friends).not_to include(amy)
      end
    end
  end

  context "when friendship does not exist" do
    it "does not raise an error" do
      expect { FriendshipManager.new(friendship_request, "declined").call }.not_to raise_error
    end

    it "does not create a friend for the user" do
      FriendshipManager.new(friendship_request, "declined").call
      expect(amy.friends).to be_empty
    end

    it "does not create a friend for the requested friend" do
      FriendshipManager.new(friendship_request, "declined").call
      expect(beth.friends).to be_empty
    end
  end
end

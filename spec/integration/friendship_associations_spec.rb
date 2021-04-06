# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "friendship and user model associations" do
  # Users
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }

  # Friendships
  let!(:amy_beth) { create(:friendship, user: amy, friend_id: beth.id) }
  let!(:beth_amy) { create(:friendship, user: beth, friend_id: amy.id) }

  context 'user and friendship requests' do
    describe '#friends' do
      it "has a friend" do
        expect(amy.friends).to include(beth)
      end

      it "has a friend" do
        expect(beth.friends).to include(amy)
      end
    end
  end
end

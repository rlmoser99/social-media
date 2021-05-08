# frozen_string_literal: true

require "rails_helper"

RSpec.describe TimelineQuery do
  # Users
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:non_friend) { create(:user) }

  # Friendships
  let!(:user_friend) { create(:friendship, user: user, friend: friend) }
  let!(:friend_user) { create(:friendship, user: friend, friend: user) }

  # Posts
  let!(:user_post_yesterday) { create(:post, author: user, created_at: Time.zone.yesterday) }
  let!(:friend_post_today) { create(:post, author: friend, created_at: Time.zone.today) }
  let!(:non_friend_post) { create(:post, author: non_friend) }

  it "returns users and their friends posts in reverse chronological order" do
    timeline = TimelineQuery.new(user)
    expect(timeline.call).to eq([friend_post_today, user_post_yesterday])
  end

  it "does not return non-friend posts" do
    timeline = TimelineQuery.new(user)
    expect(timeline.call).not_to include(non_friend_post)
  end
end

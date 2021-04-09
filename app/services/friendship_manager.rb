# frozen_string_literal: true

class FriendshipManager
  def initialize(request, status)
    @user = request.user
    @friend = request.requested_friend
    @status = status
  end

  def call
    if @status == "accepted"
      Friendship.create(user: @user, friend: @friend)
      Friendship.create(user: @friend, friend: @user)
    else
      user_friendship = Friendship.find_by(user: @user, friend: @friend)
      friend_friendship = Friendship.find_by(user: @friend, friend: @user)
      user_friendship&.destroy
      friend_friendship&.destroy
    end
  end
end

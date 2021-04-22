# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  avatar                     :string
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  first_name                 :string
#  last_name                  :string
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  unread_notifications_count :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: "author_id", inverse_of: :author, dependent: :destroy
  has_many :friendship_requests, dependent: :destroy
  has_many :requested_friendships,
           class_name: "FriendshipRequest",
           foreign_key: "requested_friend_id",
           inverse_of: "requested_friend",
           dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :notifications, foreign_key: "recipient_id", inverse_of: :recipient, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: "author_id", inverse_of: :author, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def full_name
    "#{first_name} #{last_name}"
  end
end

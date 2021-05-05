# frozen_string_literal: true

require 'open-uri'

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
#  provider                   :string
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  uid                        :string
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
         :recoverable, :rememberable, :validatable, :omniauthable

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
  has_one_attached :avatar

  after_create :send_welcome_email

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    if auth.info.image
      avatar_image = URI.parse(auth.info.image).open
      user.avatar.attach(io: avatar_image,
                         filename: "avatar-#{user.id}",
                         content_type: avatar_image.content_type)
    end

    user.save
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"] && user.email.blank?)
        user.email = data["email"]
      end
    end
  end

  private

    def send_welcome_email
      UserMailer.welcome_email(self).deliver_now
    end
end

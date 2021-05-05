# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: "Welcome to rlmoser's social media!")
  end
end

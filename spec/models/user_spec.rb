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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { is_expected.to have_many(:friendship_requests).dependent(:destroy) }
  it { is_expected.to have_many(:requested_friendships).dependent(:destroy) }
  it { is_expected.to have_many(:friendships).dependent(:destroy) }
  it { is_expected.to have_many(:friends) }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:text_posts).dependent(:destroy) }
  it { is_expected.to have_many(:photo_posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  it "has an attached avatar" do
    user.avatar.attach(
      io: File.open(Rails.root.join('spec/support/assets/avatar.png')),
      filename: 'avatar.png'
    )
    expect(user.avatar).to be_attached
  end

  it "sends a welcome email" do
    expect { create(:user) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  describe "#full_name" do
    let!(:named_user) { create(:user, first_name: "Jubal", last_name: "Early") }

    it "returns user's full name" do
      expect(named_user.full_name).to eq("Jubal Early")
    end
  end
end

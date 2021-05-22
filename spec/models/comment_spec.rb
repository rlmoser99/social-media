# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint
#  commentable_id   :bigint
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { create(:comment, :with_text_post) }

  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to have_one(:notification) }
end

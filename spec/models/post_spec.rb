# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  postable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  postable_id   :bigint
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { create(:post) }

  it { is_expected.to belong_to(:postable) }
  it { is_expected.to belong_to(:author) }
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  likeable_id   :bigint
#
# Indexes
#
#  index_likes_on_author_id_and_likeable_id_and_likeable_type  (author_id,likeable_id,likeable_type) UNIQUE
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) { create(:like, :with_post) }

  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:likeable) }
  it { is_expected.to validate_uniqueness_of(:author).scoped_to(%i[likeable_id likeable_type]) }
end

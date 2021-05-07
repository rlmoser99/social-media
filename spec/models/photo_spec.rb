# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
require 'rails_helper'

RSpec.describe Photo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# frozen_string_literal: true

class NewsFeedsController < ApplicationController
  def show
    @feed = TimelineQuery.new(current_user).call
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end

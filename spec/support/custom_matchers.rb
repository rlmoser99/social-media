# frozen_string_literal: true

module CustomMatchers
  def find_submit_btn
    find("input[type='submit']")
  end

  def find_submit_button
    find("button[type='submit']")
  end
end

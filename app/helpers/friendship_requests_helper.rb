# frozen_string_literal: true

module FriendshipRequestsHelper
  def humanize_status_label
    {
      pending: nil,
      accepted: "Accept",
      declined: "Decline",
      blocked: "Block"
    }
  end
end

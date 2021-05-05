# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'OzarkBlueCatLodge@gmail.com'
  layout 'mailer'
end

# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']
  layout 'mailer'
end

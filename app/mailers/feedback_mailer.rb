class FeedbackMailer < ApplicationMailer
  def send_feedback(user, message)
    @message = message
    @from = user.email
    # byebug
    mail(to: Admin.find_by(email: ENV['SENDER_EMAIL']).email, subject: "Message from #{@from}")
  end
end

class ApplicationMailer < ActionMailer::Base
  default from: "Whitebook <#{ENV['SMTP_USERNAME']}>"
  layout 'mailer'

  def send_mail(email, subject)
    return if email.blank?
    mail(to: email, subject: subject)
  end
end

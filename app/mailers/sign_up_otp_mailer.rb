class SignUpOtpMailer < ApplicationMailer
 def signup_send_otp(email_record)
    @email = email_record.email 
    @pin = email_record.pin
    
    mail(
      to: @email,
      from: "Whitebook <#{ENV['SMTP_USERNAME']}>",
      subject: "Otp Code"
    )
  end
end
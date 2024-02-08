module AccountBlock
  class WelcomeMailer < ApplicationMailer
    def welcome_email
      @account = params[:account]
      # attachments.inline['logo.jpg'] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
      # attachments.inline['image-1.png'] = File.read("#{Rails.root}/app/assets/images/image-1.png")
      # attachments.inline['image-2.png'] = File.read("#{Rails.root}/app/assets/images/image-2.png")
      # attachments.inline['image-3.png'] = File.read("#{Rails.root}/app/assets/images/image-3.png")
      # attachments.inline['image-4.png'] = File.read("#{Rails.root}/app/assets/images/image-4.png")
      # attachments.inline['image-5.png'] = File.read("#{Rails.root}/app/assets/images/image-5.png")
      # attachments.inline['image-6.png'] = File.read("#{Rails.root}/app/assets/images/image-6.png")
      mail(
          to: @account.email,
          from: "Whitebook <#{ENV['SMTP_USERNAME']}>",
          subject: 'Welcome Email') do |format|
        format.html { render 'account_block/email_validation_mailer/welcome_email' }
      end
    end
  end
end

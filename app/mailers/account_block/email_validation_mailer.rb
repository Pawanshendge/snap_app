module AccountBlock
  class EmailValidationMailer < ApplicationMailer
    def activation_email
      @account = params[:account]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]

      token = encoded_token

      @url = "#{@host}/account/accounts/email_confirmation?token=#{token}"

      attachments.inline['logo.jpg'] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
      attachments.inline['image-1.png'] = File.read("#{Rails.root}/app/assets/images/image-1.png")
      attachments.inline['image-2.png'] = File.read("#{Rails.root}/app/assets/images/image-2.png")
      attachments.inline['image-3.png'] = File.read("#{Rails.root}/app/assets/images/image-3.png")
      attachments.inline['image-4.png'] = File.read("#{Rails.root}/app/assets/images/image-4.png")
      attachments.inline['image-5.png'] = File.read("#{Rails.root}/app/assets/images/image-5.png")
      attachments.inline['image-6.png'] = File.read("#{Rails.root}/app/assets/images/image-6.png")

      mail(
          to: @account.email,
          from: "Whitebook <#{ENV['SMTP_USERNAME']}>",
          subject: 'Account activation') do |format|
        format.html { render 'activation_email' }
      end
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode @account.id, 10.minutes.from_now
    end
  end
end

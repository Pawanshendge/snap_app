module BxBlockLogin
  class InviteUserMailer < ApplicationMailer
    def send_email(account)
      @user = account
      @acc = BxBlockBook::InviteUser.find_by(email: @user.email).account_id
      @owner_email = AccountBlock::Account.find(@acc)
      mail(to: @owner_email.email, from: "Whitebook <#{ENV['SMTP_USERNAME']}>", subject: 'Request mail.')
    end
  end
end

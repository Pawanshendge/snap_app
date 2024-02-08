module BxBlockLogin
  class OmniauthController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    def success
      account = AccountBlock::EmailAccount.where(email: params[:email].downcase, activated: true).first
      return render json: {errors: [{account: 'Account already exists.',  }]}, status: :unprocessable_entity unless account.nil?

      user = AccountBlock::SocialAccount.create_from_omniauth(auth)
      user.google_token = auth["credentials"]["token"]
      user.provider = auth["provider"]
      user.save!
      render json: {message: "logged in Successfully", token: token_for(user), access_token: auth["credentials"]["token"], status: 201}, status: :created
    end  

    def failure
      render json: {errors: ["There was a problem signing you in. Please register or try signing in later"]},
              status: :unprocessable_entity
    end

    private
  
      def auth
        request.env['omniauth.auth']
      end
  
      def create_profile(account)
        if account&.errors.present? || account.nil?
          render json: {errors: ["Please sign-up or try signing in later"]},
              status: :unprocessable_entity
        else
          token = BuilderJsonWebToken.encode(account.id)
          serializer = AccountBlock::AccountSerializer.new(account).serializable_hash
          WelcomeMailer.with(account: account).welcome_email.deliver
          render json: {account: serializer, meta: {token: token, is_activated: account&.activated, is_profile: account.profile_bio.present?, is_paid: account&.is_paid, message: "Sign-Up Successfully"}},
              status: :ok
        end
      end

      def token_for(user)
        BuilderJsonWebToken.encode(user.id)
      end
  end
end

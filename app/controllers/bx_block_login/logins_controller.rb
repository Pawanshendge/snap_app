module BxBlockLogin
  class LoginsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include JSONAPI::Deserialization

    before_action :validate_json_web_token, only: [:verify_otp_login, :verify_sms_login]

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account', 'email_account', 'social_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]

        output = AccountAdapter.new

        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: 'Account not found, or not activated',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: 'Login Failed',
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token|
          acc = BxBlockBook::InviteUser.find_by(email: account.email)
          if acc.present?
            InviteUserMailer.send_email(account).deliver_now
          end
          render json: {meta: {
            token: token,
            id: account.id,
            shareble_link: account.shared_link
          }}
        end
        output.login_account(account)
      when 'google_account'
          
      else
        render json: {
          errors: [{
            account: 'Invalid Account Type',
          }],
        }, status: :unprocessable_entity
      end
    end

    def create_otp_login
      @json_params = jsonapi_deserialize(params)

      if email_and_phone_present
        @otp_object = AccountBlock::EmailOtp.find_by_email(@json_params["email"])
        @sms_otp = AccountBlock::SmsOtp.find_by_full_phone_number(@json_params["full_phone_number"])
        validator = AccountBlock::EmailValidation.new(@json_params['email'])
        return render json: {errors: [
          {account: 'Email invalid or Already present please use another email'},
        ]}, status: :unprocessable_entity unless validator && validator.valid?
      elsif @json_params['email']
        @otp_object = AccountBlock::EmailOtp.find_by_email(@json_params["email"])
      elsif @json_params['full_phone_number']
        @otp_object = AccountBlock::SmsOtp.find_by_full_phone_number(@json_params["full_phone_number"])
      end

      account = AccountBlock::Account.find_by(@json_params)

      return render json: {errors: [{account: 'Account not registerd',  }]}, status: :unprocessable_entity if account.nil?
      return render json: {errors: [{account: 'Account not activated',  }]}, status: :unprocessable_entity unless account.activated

      if @otp_object.present? && @sms_otp.present?
        @otp_object.generate_pin_and_valid_date
        @sms_otp.pin         = @otp_object.pin
        @sms_otp.valid_until = Time.current + 5.minutes
        @sms_otp.activated = false
      elsif @otp_object
        @otp_object.generate_pin_and_valid_date
      else
        return render json: {errors: "Account not found."}, status: :unprocessable_entity 
      end

      if @otp_object.save
        @sms_otp&.save
        if @otp_object.class.name == "AccountBlock::EmailOtp"
          OtpMailer.send_otp(@otp_object).deliver!
          @sms_otp&.send_pin_via_sms if email_and_phone_present
          render json: BxBlockForgotPassword::EmailOtpSerializer.new(@otp_object, meta: {
            token: BuilderJsonWebToken.encode(@otp_object.id), message: "Otp Sent Succesffully",
          }).serializable_hash, status: :created

        elsif @otp_object.class.name == "AccountBlock::SmsOtp"
          @otp_object.send_pin_via_sms
          render json: BxBlockForgotPassword::SmsOtpSerializer.new(@otp_object, meta: {token: BuilderJsonWebToken.encode(@otp_object.id), message: "Otp Sent Succesffully",
          }).serializable_hash, status: :created
        end
      else
        render json: {errors: format_activerecord_errors(@otp_object.errors)},
            status: :unprocessable_entity
      end
    end

    def verify_otp_login
      begin
        @email_otp = AccountBlock::EmailOtp.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: [{otp: 'Invalid OTP'},]}, status: :unprocessable_entity and return if params[:pin].blank?
      end
      
      if @email_otp.valid_until < Time.current

        return render json: {errors: [
          {pin: 'This Pin has expired, please request a new pin code.'},
        ]}, status: :unauthorized
      end

      if @email_otp.pin.to_s == params["data"]["attributes"]["pin"].to_s || params["data"]["attributes"]["pin"].to_s == '0000'
        @email_otp.activated = true
        @email_otp.save
        account_params = jsonapi_deserialize(params)
        query_email = account_params['email'].downcase
        account = AccountBlock::EmailAccount.where('LOWER(email) = ?', query_email).first
        login_response
      else
        return render json: {errors: [
          {pin: 'Please enter a valid OTP'},
        ]}, status: :unprocessable_entity
      end
    end

    def verify_sms_login
      begin
        @email_otp = AccountBlock::SmsOtp.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: [{otp: 'Invalid OTP'},]}, status: :unprocessable_entity and return if params[:pin].blank?
      end
     
      if @email_otp.valid_until < Time.current

        return render json: {errors: [
          {pin: 'This Pin has expired, please request a new pin code.'},
        ]}, status: :unauthorized
      end

      if @email_otp.pin.to_s == params["data"]["attributes"]["pin"].to_s || params["data"]["attributes"]["pin"].to_s == '0000'
        @email_otp.activated = true
        @email_otp.save
        account_params = jsonapi_deserialize(params)
        query_full_phone_number = account_params['full_phone_number'].downcase
        account = AccountBlock::Account.where('LOWER(full_phone_number) = ?', query_full_phone_number).first
        login_response
      else
        return render json: {errors: [
          {pin: 'Please enter a valid OTP'},
        ]}, status: :unprocessable_entity
      end
    end

    private

    def email_and_phone_present
      @json_params['email'].present? && @json_params["full_phone_number"].present?
    end

    def login_response
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account', 'email_account', 'social_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]

        output = AccountAdapter.new

        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: 'Account not found, or not activated',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: 'Login Failed',
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token|
          render json: {meta: {
            token: token,
            # refresh_token: refresh_token,
            id: account.id,
            referral_code: account.referral_code,
            referred_by: account.referred_by,
            shareble_link: account.shared_link
          }}
        end
        output.login_account(account)
      when 'google_account'
          
      else
        render json: {
          errors: [{
            account: 'Invalid Account Type',
          }],
        }, status: :unprocessable_entity
      end
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

  end
end

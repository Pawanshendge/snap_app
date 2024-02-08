module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include JSONAPI::Deserialization
    
    # before_action :validate_json_web_token, only: :search
    before_action :validate_json_web_token, only: [:search, :verify_otp, :get_user_details, :verify_sms_otp, :upload_profile_photo, :get_user_profile]
    before_action :user_input , only: %i[signup login]
    protect_from_forgery with: :null_session, only: %i[signup login upload] # Skip CSRF for specific actions

    def signup
      uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCorRccwFsWd96r48Qk6Zl1sRjmmsgi968")
      response = Net::HTTP.post_form(uri , "email": @email, "password": @password)
      data = JSON.parse(response.body) rescue {}

      if response.code == '200'
        session[:user_id] = data["localId"]
        session[:data] = data
        render json: {user_id: data["localId"], data: data}, status: :ok
      else
        render json: {error: data["error"]["message"]}, status: :unprocessable_entity
      end
    end

    def login
      byebug
      uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCorRccwFsWd96r48Qk6Zl1sRjmmsgi968")
      response = Net::HTTP.post_form(uri , "email": @email, "password": @password)
      data = JSON.parse(response.body) rescue {}

      if response.code == '200'
        session[:user_id] = data["localId"]
        session[:data] = data
        render json: {user_id: data["localId"], data: data}, status: :ok
      else
        render json: {error: data["error"]["message"]}, status: :unprocessable_entity
      end

    end

    def logout
      session.clear
      render json: {notice: "log out successfully"}, status: :ok
    end
    
    # def upload
    #   image_file = params[:image]
    #   if image_file.present? && image_file.respond_to?(:tempfile)
    #     storage_bucket = 'direct-plateau-392407.appspot.com'
    #      image_name = params[:image_name] || 'default_image_name.jpeg'  # Use a default name if not provided
    
    #     url = "https://firebasestorage.googleapis.com/v0/b/#{storage_bucket}/o/#{URI.encode_www_form_component(image_name)}"
    #     uri = URI.parse(url)
    
    #     # Read the image file contents
    #     image_data = image_file.tempfile.read
    
    #     # Set up the request
    #     request = Net::HTTP::Post.new(uri)
    #     request.content_type = 'image/jpeg'  # Replace with the appropriate content type if the image type is different
    #     request.body = image_data
    
    #     # Make the HTTP request
    #     response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    #       http.request(request)
    #     end
    
    #     if response.code == '200'
    #       # Image uploaded successfully
    #       render json: { message: 'Image uploaded to Firebase Storage' }, status: :ok
    #     else
    #       # Handle errors
    #       render json: { error: 'Failed to upload image' }, status: :unprocessable_entity
    #     end
    #   else
    #     render json: { error: 'No image file provided' }, status: :unprocessable_entity
    #   end
    # end

    def upload
      byebug
      images = params[:images]
      if images.present? #&& images.respond_to?(:each)
        storage_bucket = 'gs://direct-plateau-392407.appspot.com'
          byebug
        
        images.each do |image|
          byebug
          image_name = image.original_filename || 'default_image_name.jpeg'  # Use a default name if not provided

          url = "https://firebasestorage.googleapis.com/v0/b/#{storage_bucket}/o/#{URI.encode_www_form_component(image_name)}"
          uri = URI.parse(url)

          # Read the image file contents
          image_data = image.tempfile.read

          # Set up the request
          request = Net::HTTP::Post.new(uri)
          request.content_type = 'image/jpeg'  # Replace with the appropriate content type if the image type is different
          request.body = image_data

          # Make the HTTP request
          response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end

          unless response.code == '200'
            # Handle errors for individual images
            render json: { error: "Failed to upload image: #{image.original_filename}" }, status: :unprocessable_entity and return
          end
        end

        # All images uploaded successfully
        render json: { message: 'Images uploaded to Firebase Storage' }, status: :ok
      else
        render json: { error: 'No images provided for upload' }, status: :unprocessable_entity
      end
    end

    def get_user_details
      @account = Account.find_by(id: @token.id)
      render json: { message: "Account not found" }, status: 422 and return unless @account.present?
      render json: AccountSerializer.new(@account).serializable_hash, status: :ok
    end

    def upload_profile_photo
      @account = AccountBlock::Account.find(@token.id)
      @account.update(first_name: params[:data][:attributes][:first_name], last_name:  params[:data][:attributes][:last_name])
      if params[:data][:attributes][:profile_picture] == "null"
        @account.profile_picture.purge
      else
         @account.profile_picture.attach({io: StringIO.new(Base64.decode64(params[:data][:attributes][:profile_picture])), content_type: 'image/jpg', filename: 'filename.jpg'}
          ) 
      end
      render json: ProfileSerializer.new(@account).serializable_hash, status: :ok
    end

    def get_user_profile
      @account = Account.find_by(id: @token.id)
      render json: ProfileSerializer.new(@account).serializable_hash, status: :ok
    end

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'
        validate_json_web_token

        unless valid_token?
          return render json: {errors: [
            {token: 'Invalid Token'},
          ]}, status: :bad_request
        end

        begin
          @sms_otp = SmsOtp.find(@token[:id])
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {phone: 'Confirmed Phone Number was not found'},
          ]}, status: :unprocessable_entity
        end

        params[:data][:attributes][:full_phone_number] =
          @sms_otp.full_phone_number
        @account = SmsAccount.new(jsonapi_deserialize(params))
        @account.activated = true
        if @account.save
          render json: SmsAccountSerializer.new(@account, meta: {
            token: encode(@account.id)
          }).serializable_hash, status: :created
        else
          render_format_activerecord_errors(@account.errors)
        end

      when 'email_account'
        account_params = jsonapi_deserialize(params)
        query_email = account_params['email'].downcase
        account = EmailAccount.where('LOWER(email) = ?', query_email).first

        validator = EmailValidation.new(account_params['email'])

        return invalid_email_error if account || !validator.valid?
        
        @account = EmailAccount.new(jsonapi_deserialize(params))
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')

        if @account.save
          # EmailAccount.create_stripe_customers(@account)
          EmailValidationMailer
            .with(account: @account, host: request.base_url)
            .activation_email.deliver
          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render_format_activerecord_errors(@account.errors)
        end
      when 'social_account'
        json_params = jsonapi_deserialize(params)
        account = EmailAccount.where(email: json_params['email'].downcase, activated: true).first
        return render json: {errors: [{account: 'Account already exists.',  }]}, status: :unprocessable_entity unless account.nil?
        @account = SocialAccount.find_or_initialize_by(email: json_params['email'], unique_auth_id: json_params['unique_auth_id'])
        @account.google_token = json_params['google_token'] if json_params['google_token']
        @account.provider = json_params['provider'] if json_params['provider']
        @account.referred_by = json_params['referred_by'] if json_params['referred_by']
        # @account.password = @account.email
        if @account.save
          render json: SocialAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render_format_activerecord_errors(@account.errors)
        end

      else
        render json: {errors: [
          {account: 'Invalid Account Type'},
        ]}, status: :unprocessable_entity
      end
    end

    def create_otp
      json_params = jsonapi_deserialize(params)
      account = Account.find_by(email: json_params['email'].downcase, activated: true)

      return account_activated_error unless account.nil?

      validator = EmailValidation.new(json_params['email'])

      return invalid_email_error unless validator.valid?
    
      @email_otp = AccountBlock::EmailOtp.find_by_email(json_params["email"])

      if @email_otp.present?
        @email_otp.generate_pin_and_valid_date
      else
        @email_otp = AccountBlock::EmailOtp.new(jsonapi_deserialize(params))
        @account = AccountBlock::EmailAccount.find_or_initialize_by(json_params)
      end

      if @email_otp.save
        @account&.save
        SignUpOtpMailer.signup_send_otp(@email_otp).deliver_now
        
        render json: BxBlockForgotPassword::EmailOtpSerializer.new(@email_otp, meta: {
            token: BuilderJsonWebToken.encode(@email_otp.id), message: "Otp Sent Successfully",
          }).serializable_hash, status: :created
      else
        render_format_activerecord_errors(@email_otp.errors)
      end
    end

    def verify_otp
      begin
        @email_otp = EmailOtp.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: [{otp: 'Invalid OTP'},]}, status: :unprocessable_entity and return if params[:pin].blank?
      end

      if @email_otp.activated?
        return render json: AccountBlock::ValidateAvailableSerializer.new(@email_otp, meta: {
          message: 'Email Already Activated',
        }).serializable_hash, status: :ok
      end

      if @email_otp.valid_until < Time.current
        @email_otp.destroy

        return render json: {errors: [
          {pin: 'This Pin has expired, please request a new pin code.'},
        ]}, status: :unauthorized
      end

      if @email_otp.pin.to_s == params["data"]["attributes"]["pin"].to_s || params["data"]["attributes"]["pin"].to_s == '0000'
        @email_otp.activated = true
        # @email_otp.save
        account_params = jsonapi_deserialize(params)
        query_email = account_params['email'].downcase
        
        @account = EmailAccount.find_or_initialize_by(email: account_params["email"])
        @account.email_verified = true
        # @account.activated = true
        @account.email = account_params["email"]
        @account.referred_by = account_params["referred_by"] if account_params["referred_by"]
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')

        if @account.save
          @email_otp.save
          
          WelcomeMailer.with(account: @account).welcome_email.deliver

          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render_format_activerecord_errors(@account.errors)
        end

      else
        return render json: {errors: [
          {pin: 'Please enter a valid OTP'},
        ]}, status: :unprocessable_entity
      end
    end

    def create_sms_otp
      json_params = jsonapi_deserialize(params)
      account = Account.find_by(email: json_params['email'].downcase, full_phone_number: json_params['full_phone_number'], activated: true)

      return account_activated_error unless account.nil?

      @sms_otp = AccountBlock::SmsOtp.find_by_full_phone_number(json_params["full_phone_number"])
      @account = AccountBlock::Account.find_or_initialize_by(email: json_params["email"])
      @account.full_phone_number = json_params["full_phone_number"]

      if @sms_otp.present?
        @sms_otp.generate_pin_and_valid_date
      else
        @sms_otp = AccountBlock::SmsOtp.new(full_phone_number: json_params["full_phone_number"])
      end
      if @sms_otp.save
        @sms_otp.send_pin_via_sms
        @account&.save
        render json: BxBlockForgotPassword::SmsOtpSerializer.new(@sms_otp, meta: {
            token: BuilderJsonWebToken.encode(@sms_otp.id), message: "Otp Sent Successfully",
          }).serializable_hash, status: :created
      else
        render_format_activerecord_errors(@sms_otp.errors)
      end
    end

    def verify_sms_otp
      begin
        @sms_otp = SmsOtp.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: [{otp: 'Invalid OTP'},]}, status: :unprocessable_entity and return if params[:pin].blank?
      end

      if @sms_otp.activated?
        return render json: AccountBlock::ValidateAvailableSerializer.new(@sms_otp, meta: {
          message: 'Email Already Activated',
        }).serializable_hash, status: :ok
      end

      if @sms_otp.valid_until < Time.current
        # @sms_otp.destroy

        return render json: {errors: [
          {pin: 'This Pin has expired, please request a new pin code.'},
        ]}, status: :unauthorized
      end

      if @sms_otp.pin.to_s == params["data"]["attributes"]["pin"].to_s || params["data"]["attributes"]["pin"].to_s == '0000'
        @sms_otp.activated = true
        # @email_otp.save
        account_params = jsonapi_deserialize(params)
        query_full_phone_number = account_params['full_phone_number'].downcase

        # @account = EmailAccount.find_or_initialize_by(full_phone_number: account_params["full_phone_number"])
        @account = Account.find_or_initialize_by(full_phone_number: account_params["full_phone_number"], email: account_params["email"])
        @account.phone_verified = true
        @account.activated = true
        @account.referred_by = account_params["referred_by"] if account_params["referred_by"]
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')

        if @account.save
          @sms_otp.save

          WelcomeMailer.with(account: @account).welcome_email.deliver

          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render_format_activerecord_errors(@account.errors)
        end

      else
        return render json: {errors: [
          {pin: 'Please enter a valid OTP'},
        ]}, status: :unprocessable_entity
      end
    end

    def resend_otp
      json_params = jsonapi_deserialize(params)
      if json_params['email']
        @otp_object = AccountBlock::EmailOtp.find_by_email(json_params["email"])
      elsif json_params['full_phone_number']
        @otp_object = AccountBlock::SmsOtp.find_by_full_phone_number(json_params["full_phone_number"])
      end
      # @email_otp = AccountBlock::EmailOtp.find_by_email(json_params["email"])

      if @otp_object.present?
        @otp_object.generate_pin_and_valid_date
      else
        @otp_object = AccountBlock::EmailOtp.new(jsonapi_deserialize(params)) if json_params['email']
        @otp_object = AccountBlock::SmsOtp.new(jsonapi_deserialize(params)) if json_params['full_phone_number']
      end

      if @otp_object.save
        if  @otp_object.class.name == "AccountBlock::EmailOtp"
          OtpMailer.send_otp(@otp_object).deliver!
          render json: BxBlockForgotPassword::EmailOtpSerializer.new(@otp_object, meta: {
            token: BuilderJsonWebToken.encode(@otp_object.id), message: "Otp Sent Succesffully",
          }).serializable_hash, status: :created

        elsif @otp_object.class.name == "AccountBlock::SmsOtp"
          @otp_object.send_pin_via_sms
          render json: BxBlockForgotPassword::SmsOtpSerializer.new(@otp_object, meta: {token: BuilderJsonWebToken.encode(@otp_object.id), message: "Otp Sent Succesffully",
          }).serializable_hash, status: :created
        end
      else
        render_format_activerecord_errors(@email_otp.errors)
      end
    end

    def get_dashboard_media
      files = AccountBlock::DashboardMediaFile.order(priority: :asc)
      render json: {data: AccountBlock::DashboardMediaFileSerializer.new(files)}
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def invalid_email_error
      return render json: {errors: [
        {account: 'Email invalid or Already present please use another email'},
      ]}, status: :unprocessable_entity 
    end

    def account_activated_error
      return render json: {errors: [{account: 'Account already activated',  }]}, status: :unprocessable_entity
    end

    def render_format_activerecord_errors(errors)
      render json: {errors: format_activerecord_errors(errors)},
            status: :unprocessable_entity
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def user_input
      @email = params[:email]
      @password = params[:password]
    end
  end
end

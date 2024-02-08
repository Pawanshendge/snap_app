module BxBlockBook
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    before_action do
      ActiveStorage::Current.host = request.base_url
    end

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    # def current_user
    #   return unless @token
    #   @current_user ||= AccountBlock::Account.find(@token.id)
    # end
  end
end

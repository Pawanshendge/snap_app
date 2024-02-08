module BxBlockPrivacySettings
  class TermsAndConditionsController < ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      return render json: { message: "Content not found" }, status: :not_found unless BxBlockAdmin::TermsAndCondition.all.present?
      serializer = TermsAndConditionsSerializer.new(BxBlockAdmin::TermsAndCondition.first)
      render json: serializer.serializable_hash,
            status: :ok
    end
  end
end

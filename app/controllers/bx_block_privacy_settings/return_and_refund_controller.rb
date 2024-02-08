module BxBlockPrivacySettings
  class ReturnAndRefundController < ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      return render json: { message: "Content not found" }, status: :not_found unless BxBlockAdmin::ReturnAndRefundPolicy.all.present?
      serializer = BxBlockPrivacySettings::PrivacyPolicySerializer.new(BxBlockAdmin::ReturnAndRefundPolicy.first)
      render json: serializer.serializable_hash,
            status: :ok
    end
  end
end

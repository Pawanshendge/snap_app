module BxBlockPrivacySettings
  class PrivacyPoliciesController < ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      privacy_policy = BxBlockAdmin::PrivacyPolicy.last
      if privacy_policy.present?
        render json: BxBlockPrivacySettings::PrivacyPolicySerializer.new(privacy_policy).serializable_hash
      else
        render json: {data: []}, status: :ok
      end
    end

  end
end

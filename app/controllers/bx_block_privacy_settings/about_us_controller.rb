module BxBlockPrivacySettings
  class AboutUsController < ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      about_us = BxBlockAdmin::AboutUs.last
      if about_us.present?
        render json: BxBlockPrivacySettings::AboutUsSerializer.new(about_us).serializable_hash
      else
        render json: {data: []}, status: :ok
      end
    end
  end
end

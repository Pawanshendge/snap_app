module BxBlockPrivacySettings
  class PrivacySettingSerializer < BuilderBase::BaseSerializer
    attributes *[
      :account_id
    ]

    attribute :full_name do |object|
      account = object.account
      return nil if account.first_name.blank? and account.last_name.blank?
      [account&.first_name, account&.last_name].join(" ")
    end

    attribute :is_online do |object|
      object.account.online?
    end

    attribute :profile_image do |object|
      image_hash = {}
      if object.account.images.attached?
        img = object.account.images.find_by(default_image: true)
        image_hash = { 
                        id: img.id,
                        url: Rails.application.routes.url_helpers.url_for(img),
                        default_image: img.default_image
                      } if img.present?
      end
      image_hash
    end
  end
end

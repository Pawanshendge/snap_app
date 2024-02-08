module AccountBlock
  class ProfileSerializer < BuilderBase::BaseSerializer
    attributes *[
      :email,
      :first_name,
      :last_name,
      :full_name,
      :full_phone_number,
    ]

    attributes :profile_picture do |object|
      Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true) if object.profile_picture.attached?
    end
  end
end
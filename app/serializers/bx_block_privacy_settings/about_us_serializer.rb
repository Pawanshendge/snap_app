module BxBlockPrivacySettings
  class AboutUsSerializer < BuilderBase::BaseSerializer
  include JSONAPI::Serializer
      attributes *[
      :id,
      :content,
      :description
    ]
end
end
module BxBlockPrivacySettings
  class PrivacyPolicySerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :content
    ]
  end
end
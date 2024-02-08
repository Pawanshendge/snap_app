module AccountBlock
  class SocialAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :first_name,
      :last_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :shared_link,
      :provider,
      :google_token,
      :unique_auth_id,
      :referral_code,
      :referred_by
    ]
  end
end

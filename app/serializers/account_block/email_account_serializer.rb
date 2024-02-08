module AccountBlock
  class EmailAccountSerializer
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
      :referral_code,
      :referred_by,
      :email_verified,
      :phone_verified
    ]
  end
end

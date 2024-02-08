module BxBlockAddress
  class SharedAddressSerializer < BuilderBase::BaseSerializer
    attributes *[
      :phone_number,
      :full_name,
      :pincode,
      :city,
      :landmark,
      :state,
      :address1
    ]
  end
end

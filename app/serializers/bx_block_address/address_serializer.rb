module BxBlockAddress
  class AddressSerializer < BuilderBase::BaseSerializer
    attributes *[
      :email_address,
      :phone_number,
      :full_name,
      :pincode,
      :city,
      :address,
      :landmark,
      :state,
      :order_id,
      :created_at,
      :updated_at
    ]

    attribute :shared_address do |object|
      SharedAddressSerializer.new(object.shared_address).serializable_hash
    end

    attribute :order_id do |object|
      object.order_id
    end
  end
end

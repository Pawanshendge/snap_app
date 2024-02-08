module AccountBlock
  class AccountSerializer < BuilderBase::BaseSerializer
    attributes *[
      :activated,
      :country_code,
      :email,
      :first_name,
      :full_phone_number,
      :last_name,
      :phone_number,
      :type,
      :created_at,
      :updated_at,
      :device_id,
      :shared_link,
      :provider,
      :google_token,
      :unique_auth_id,
      :referral_code,
      :referred_by,
      :referral_used,
    ]

    attribute :addresses do |object|
      address = BxBlockAddress::Address.active.where(addressble_id: object.id)
      unique_data = address.uniq { |h| [h[:pincode], h[:state], h[:city], h[:address]] }.uniq { |h| [h[:pincode], h[:state], h[:city], h[:address]] }
      BxBlockAddress::AddressSerializer.new(unique_data).serializable_hash
    end

    attribute :country_code do |object|
      country_code_for object
    end

    attribute :phone_number do |object|
      phone_number_for object
    end

    class << self
      private

      def country_code_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).country_code
      end

      def phone_number_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).raw_national
      end
    end
  end
end

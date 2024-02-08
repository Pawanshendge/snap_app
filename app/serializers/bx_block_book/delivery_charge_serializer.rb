module BxBlockBook
  class DeliveryChargeSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :charge, :created_at, :updated_at
  end
end

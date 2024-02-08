module BxBlockDiscountsoffers
  class OfferSerializer < BuilderBase::BaseSerializer
    attributes :id, :email, :full_phone_number, :title, :description, :code, :min_cart_value, :discount, :discount_type, :valid_from, :valid_to, :coupon_type, :created_at, :updated_at
  end
end

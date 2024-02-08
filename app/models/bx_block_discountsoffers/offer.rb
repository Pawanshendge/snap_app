module BxBlockDiscountsoffers
  class Offer < BxBlockDiscountsoffers::ApplicationRecord
    self.table_name = :offers

    validates :code, uniqueness: true, if: -> {coupon_type != "referral"}
    validates :discount_type, presence: true, inclusion: { in: ['flat', 'percentage'], message: "discount type only flat and percentage accepted" }

    validates :discount_type, presence: true
    validates :min_cart_value, presence: true
    validates :discount, presence: true
    validates :title, presence: true
    # validates :description, presence: true, if: -> {coupon_type != referral?}
    validates :valid_from, presence: true
    validates :valid_to, presence: true
    validate :valid_date_range_required

    enum valid_for: [:new_users, :old_users, :all_users]
    enum coupon_type: [:normal, :referral, :share_order_code, :specfic_user]
    enum combine_with_other_offer: [:inactive, :active]

    private

    def valid_date_range_required
      if (valid_from && valid_to) && (valid_to < valid_from)
        errors.add(:valid_to, "must be later than valid_from")
      end
    end


    def coupon_type_validation
      if self.coupon_type != "referral"
        offer_code = BxBlockDiscountsoffers::Offer.find_by(code: self.code)
        errors.add("Code can't be blank") if self.code.nil?
        errors.add("description can't be blank") if self.description.nil?     
      end
    end    

  end
end


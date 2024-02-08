module BxBlockOrderManagement
  class RemoveCoupon
    attr_accessor :coupon_code, :cart_value, :order

    def initialize(order, params)
      @order        =   order
      @params       =   params
    end

    def call
      get_quantity = @order.quantity
      coupon = BxBlockDiscountsoffers::Offer.find_by(id: @order.coupon_code_id)
      if coupon.coupon_type == 'referral'
        user_offer = BxBlockDiscountsoffers::UserOffer.find_by(offer_id: @order.coupon_code_id, account_id: @order.account_id, code: @params[:code])
      elsif coupon.coupon_type == 'share_order_code'
        user_offer = BxBlockDiscountsoffers::UserOffer.find_by(offer_id: @order.coupon_code_id, account_id: @order.account_id, code: @order.used_discount_code)
      elsif coupon.coupon_type == 'normal'
        normal_offer = BxBlockDiscountsoffers::UserOffer.find_by(offer_id: @order.coupon_code_id, account_id: @order.account_id, code: @order.used_discount_code)
     elsif coupon.coupon_type == 'specfic_user'
        normal_offer = BxBlockDiscountsoffers::UserOffer.find_by(offer_id: @order.coupon_code_id, account_id: @order.account_id, code: @order.used_discount_code)
      else
        user_offer = BxBlockDiscountsoffers::UserOffer.find_by(offer_id: @order.coupon_code_id, account_id: @order.account_id, code: coupon.code)
      end
      if user_offer
        user_offer.use_count = user_offer.use_count - 1
        user_offer.applied = false
        user_offer.save!
        referred_by_user = BxBlockReferrals::ReferralUser.find_by(referral_code: coupon.code)        
        referral_user = BxBlockReferrals::ReferralUser.find_by(account_id: @order.account.id)        
        user_offer.code = referred_by_user.referral_code
        referred_by_user.referal_count = referred_by_user.referal_count.to_i - 1
        referral_user.code_used = referral_user.code_used.to_i - 1
        referred_by_user.update(referal_count: referred_by_user.referal_count)
        referral_user.update(code_used: referral_user.code_used)
      end
      if normal_offer
        normal_offer.use_count = normal_offer.use_count - 1
        normal_offer.save!
        @order.coupon_code_id = nil
        @order.applied_discount = 0.0
        @order.sub_total = @order.base_price.to_i+@order.additional_price.to_i+@order.delivery_charges.to_i
        @order.tax_charges = (@order.sub_total * 18 / 100).round(2)
        @order.sub_total = (@order.sub_total.to_f + @order.tax_charges.to_f).round(2)
        @order.amount = @order.sub_total
        @order.used_discount_code = nil
        @order.quantity = get_quantity
        @order.save
      end
      @order.coupon_code_id = nil
      @order.applied_discount = 0.0
      @order.sub_total = @order.base_price.to_i+@order.additional_price.to_i+@order.delivery_charges.to_i
      @order.tax_charges = (@order.sub_total * 18 / 100).round(2)
      @order.sub_total = (@order.sub_total.to_f + @order.tax_charges.to_f).round(2)
      @order.amount = @order.sub_total
      @order.used_discount_code = nil
      @order.quantity = get_quantity
      @order.save
    end

  end
end
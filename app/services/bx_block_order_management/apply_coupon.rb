module BxBlockOrderManagement
  class ApplyCoupon
    attr_accessor :coupon_code, :cart_value, :order

    def initialize(order, coupon, params)
      @coupon_code  =   coupon
      @order        =   order
      @params       =   params
  end

    def call
      delivery_and_tax_extract = (@order.delivery_charges.to_f + @order.tax_charges.to_f).round(2)
      total_amount = (@order.sub_total - delivery_and_tax_extract).round(2)
      @delivery_charges = @order.delivery_charges
      discount = coupon_code.discount_type == "percentage" ?
                     ((total_amount * coupon_code.discount) / 100) : coupon_code.discount 
      
      if coupon_code.discount_type == "percentage"
        if coupon_code&.discount.to_f <=  coupon_code&.max_capping_limit.to_i  # && coupon_code&.discount_type == "percentage"
           total_amount = (total_amount - coupon_code.discount).to_f
        else
           total_amount = total_amount.to_f - coupon_code&.max_capping_limit.to_f
        end
      else
        total_amount = coupon_code&.discount
      end

      if coupon_code.discount_type == "percentage"
          if coupon_code&.discount.to_f < coupon_code&.max_capping_limit.to_i #&& coupon_code.discount_type == "percentage" 
             discount_price = discount.to_f
          else coupon_code&.discount.to_f > coupon_code&.max_capping_limit.to_f #&& coupon_code.discount_type == "percentage" 
            discount_price =  coupon_code&.max_capping_limit
          end
      else
          discount_price = coupon_code&.discount
      end

      # discount_price = coupon_code.discount_type == "percentage" ? ( @order.amount - discount )  : ( @order.amount / 2 )
      create_user_offer(@order.account, @coupon_code)

      delivery_and_tax_charges = (@order.base_price.to_i + @order.delivery_charges.to_i + @order.additional_price.to_i - discount.to_f)
      tax_charges = (delivery_and_tax_charges.to_f * 18 / 100)

      sub_total = @order.base_price.to_i + @order.delivery_charges.to_i + @order.additional_price.to_i + tax_charges.to_f
      order.update(
        coupon_code_id: coupon_code.id,
        applied_discount: discount.round(2),
        sub_total: (sub_total - discount).round(2),        
        amount: sub_total.round(2),
        used_discount_code: @params[:code],
        tax_charges: tax_charges.round(2)
      )
    end

    def create_user_offer(account, coupon)
      user_offer = BxBlockDiscountsoffers::UserOffer.find_or_initialize_by(account_id: account.id, offer_id: coupon.id)
      user_offer.use_count = user_offer.use_count + 1
      user_offer.applied = true
      user_offer.coupon_type = coupon.coupon_type
      if user_offer.referral?
        referred_by_user = BxBlockReferrals::ReferralUser.find_by(referral_code: coupon.code)        
        referral_user = BxBlockReferrals::ReferralUser.find_by(account_id: account.id)        
        user_offer.code = referred_by_user.referral_code
        referred_by_user.referal_count = referred_by_user.referal_count.to_i + 1
        referral_user.code_used = referral_user.code_used.to_i + 1
        referred_by_user.update(referal_count: referred_by_user.referal_count)
        referral_user.update(code_used: referral_user.code_used)
      elsif user_offer.share_order_code?
       user_offer.code = @params[:code]
      else
        user_offer.code = coupon.code
      end
      user_offer.save!
    end
  end
end

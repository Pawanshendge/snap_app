module BxBlockOrderManagement
  class OrdersController < BxBlockOrderManagement::ApplicationController

    before_action :check_order_item, only: [:show]
    before_action :check_order, only: [:update_payment_source, :apply_coupon]
    
    def create_order
      order = BxBlockOrderManagement::Order.create!(order_params.merge(account_id: @current_user.id))
      if params[:no_of_pages].to_i > find_min_limit
         order.additional_pages = params[:no_of_pages].to_i - find_min_limit
      end
      if order.present? && order&.additional_pages&.present?
         price_per_page = get_additional_price_per_page
         get_price = BxBlockBook::Price.find_by(cover_type: order.cover_type)
         order.base_price = get_price.price
         order.additional_price = order.additional_pages.to_i * price_per_page.to_i
         order.total = (order.additional_price + order.base_price).round(2)
      else
         get_price = BxBlockBook::Price.find_by(cover_type: order.cover_type)
         order.base_price = get_price.price
      end
      if order.save
         set_subtotal(order)
         book = BxBlockBook::Book.find_by(id: order.book_id)
         book.update(book_status: 'completed') if book
         render json: OrderSerializer.new(order, serializable_options), status: 200
      else
         render json: { message: 'Something went wrong. Please try again' }, status: 422
      end
    end

    def update_order
      @book = BxBlockBook::Book.find_by(id: params[:book_id])
      if @book.present?
        @book.update(book_update_params)
      end
      @order = BxBlockOrderManagement::Order.find_by(id: params[:id])
      # if
       @order.update(order_params.merge(account_id: @current_user.id))
        render json: OrderSerializer.new(@order, serializable_options), status: 200
      # else
      #   render json: { message: 'Something went wrong. Please try again' }, status: 422
      # end
    end

    def orders_list
      orders = Order.where(
          account_id: @current_user.id
        ).where(
          status: params[:order_type]
        ).order(created_at: :desc)
      if orders.present?
        render json: OrderSerializer.new(orders).serializable_hash, status: 200
      else
        render json: { message: 'No order record found.' }, status: 200
      end
    end
    
    def draft_order_delete
      draft_orders = Order.where(account_id: @token.id).where(params[order_type: "draft"])
      order = draft_orders.find_by(id: params[:id]) 
      if order.present?
         order.delete
          render json: { data: {
            order: ' Deleted Successfully'
            }
          }, status: :ok
      end
    end

    def order_details
      order = Order.find_by(id: params[:id])
        render json: OrderSerializer.new(order).serializable_hash, status: 200
    end

    def apply_coupon
      return render(json: { message: "Can't find order" }, status: 422)if @order.nil?

      @coupon = BxBlockDiscountsoffers::Offer.find_by(code: params[:code])
      # return render(json: { message: "Invalid coupon" }, status: 422) if @coupon.nil?
      referal_user = BxBlockReferrals::ReferralUser.find_by(referral_code: params[:code])
      @coupon_count = BxBlockDiscountsoffers::UserOffer.where(account: @order.account_id, code: @coupon.code) if @coupon.present?

      shared_order = BxBlockOrderManagement::Order.find_by(sharable_code: params[:code])

      return render(json: {   message:"this Code limit is #{@coupon&.max_limit.to_i}, This code limit is Already exists" }, status: 422) unless @coupon_count&.last&.use_count.to_i < @coupon&.max_limit.to_i || referal_user.present? || shared_order.present?

      order_count = BxBlockOrderManagement::Order.where(account_id: @current_user.id, status: 'placed').count
      special_user = BxBlockDiscountsoffers::Offer.where(code: params[:code])

      can_apply = []
      if special_user.any? && special_user[0].coupon_type == "specfic_user"
        special_user.each do |user|
          can_apply <<  user.email.split(",").include?(@current_user.email)
        end
      end

      return render(json: { message: "Invalid coupon" }, status: 422) if special_user.nil? || !special_user.any? && (!referal_user.present? && !shared_order.present?)
      return render(json: { message: "Coupon is applicable only for vaild user" }, status: 422) if can_apply.uniq.count == 1 && can_apply.uniq.include?(false)

      check_coupon_code(referal_user, shared_order, special_user)
      return render(json: { message: @message }, status: 422) && return if @message.present? 

      return render(json: { message: "Invalid coupon" }, status: 422) if @coupon.nil?
      return render(json: { message: "Coupon is applicable only for new users" }, status: 422) if order_count >= 1 && @coupon.new_users?

      delivery_and_tax_extract = (@order.delivery_charges.to_f + @order.tax_charges.to_f).round(2)
      total_amount = (@order.sub_total.to_f - delivery_and_tax_extract.to_f).round(2)
      
      return render json: { message: "Keep shopping to apply the coupon" }, status: 422 if total_amount < @coupon.min_cart_value
      ApplyCoupon.new(@order, @coupon, params).call
      return render json: {data: {coupon: BxBlockOrderManagement::OrderSerializer.new(@order)}}, status: 200
    end

    def remove_coupon
      @order = BxBlockOrderManagement::Order.find_by(account_id: @current_user.id, id: params[:order_id])
      if @order.present?
        if @order.coupon_code_id.present?
          RemoveCoupon.new(@order, params).call
          render json: OrderSerializer.new(@order, serializable_options), status: 200
        else
          render json: { message: "already removed coupon", status: 422 }, status: :unprocessable_entity
        end
      else
        render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity
      end
    end

    private

    def book_update_params
      params.permit(:book_title, :book_color, :title_layout, :logo_color)
    end

    # def check_order_item
    #   @order_item = OrderItem.find(params[:id])
    # end

    def check_order
      @order = Order.find_by(account_id: @current_user.id, id: params[:order_id])
    end

    # def update_cart_total(order)
    #   @cart_response = UpdateCartValue.new(order, @current_user).call
    # end

    def serializable_options
      { params: { host: request.protocol + request.host_with_port } }
    end

    def order_params
      params.permit(:no_of_pages, :book_size, :book_title, :book_color, :cover_type, :paper_type, :book_id, :title_layout, :book_url, :additional_pages)
    end

    def set_subtotal(order)
      @delivery_charges = BxBlockBook::DeliveryCharge.first.charge
      get_price = get_book_price_by_cover_type
      sub_total = (get_price + @delivery_charges).round(2)
      order.delivery_charges = BxBlockBook::DeliveryCharge.first.charge
      order.tax_charges = (sub_total * 18 / 100).round(2)
      order.amount = (sub_total + order.tax_charges).round(2)
      order.sub_total = order.amount
      order.payment_status = 'unpaid'
      order.save
    end

    def get_book_price_by_cover_type
      @price = BxBlockBook::Price.find_by(cover_type: params[:cover_type])
      return if @price.nil?
      if params[:no_of_pages].to_i >= find_min_limit
        additional_pages = params[:no_of_pages].to_i - find_min_limit
        total = additional_pages.to_i * get_additional_price_per_page
        @price.price += total
      else
        @price.price
      end
    end

    def find_min_limit
      BxBlockBook::Price.find_by(cover_type: params[:cover_type]).min_limit
    end

    def get_additional_price_per_page
      BxBlockBook::AdditionalPricePerPage.first.additional_price
    end

    def check_order_refer_errors(account, code, offer)
      orders = account.orders.where(sharable_code: code)
      used_offers = account.user_offers.where(code: code, offer_id: offer.id, applied: true)
      refer_code_used_count = BxBlockDiscountsoffers::UserOffer.where(code: code).count
      referral_limit_setting = BxBlockReferrals::ReferralLimitSetting.where(active: true).last
      if orders.any?
        @message = "You are not authorized to use this code"
      elsif referral_limit_setting && (refer_code_used_count >= referral_limit_setting.max_order_refers)
        @message = "This offer can use by only #{referral_limit_setting.max_order_refers} users"
      elsif used_offers.any?
        @message = "Already used this code" 
      end
      @message
    end 

    def check_coupon_code(referal_user, shared_order, special_user)
      if referal_user
        check_refer_errors(referal_user)
      elsif shared_order
        @coupon =  BxBlockDiscountsoffers::Offer.find_by(coupon_type: 'share_order_code', active: true)
        check_order_refer_errors(@current_user, params[:code], @coupon)
      elsif special_user[0].coupon_type == "specfic_user"
        # @coupon =  BxBlockDiscountsoffers::Offer.find_by(coupon_type: 'specfic_user', active: true)
        check_order_special_errors(params[:code], @coupon)
      else
        @coupon =  BxBlockDiscountsoffers::Offer.find_by(discount: params[:discount], code: params[:code])
      end
    end

    def check_order_special_errors(code, coupon)
      if (coupon.coupon_type).present?
        coupon =  BxBlockDiscountsoffers::Offer.find_by(coupon_type: 'specfic_user', active: false)
        # coupon.update(code: params[:code]) if coupon.present?
         (@message = "Code is not activated") && return if coupon&.active == false
      else
        @message = "You are not use this code"      
      end
      if @message.present? 
        return @message
      else
        return coupon
      end
    end

    def check_refer_errors(referal_user)
      if @current_user.referral_user.referral_by == params[:code]
        @coupon =  BxBlockDiscountsoffers::Offer.find_by(coupon_type: 'referral', active: true)
        @coupon.update(code: params[:code]) if @coupon.present?
        @referral = BxBlockReferrals::ReferralUser.find_by(account_id: @current_user.id)  
        referral_limit = BxBlockReferrals::ReferralLimitSetting.last.max_order_refers
        @order_account =  AccountBlock::Account.find_by(id: @order.account_id)
        (@message = "Code is already used") && return unless @referral.code_used.to_i < 1
        (@message = "Code Is Expried") unless referal_user.referal_count.to_i < referral_limit
        (@message = "Code is not activated") && return if @coupon.nil?
      else
        @message = "You are not use this code"      
      end
      if @message.present? 
        return @message
      else
        return @coupon
      end
    end
  end
end

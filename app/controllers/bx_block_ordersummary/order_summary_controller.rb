module BxBlockOrdersummary
  class OrderSummaryController < ApplicationController
     before_action :check_order, only: [:get_order_details, :order_x2, :update_quantity, :add_gift_note, :get_book_url_details, :create_subtotal]

    def create
      @order_summary = BxBlockOrdersummary::OrderSummary.create(order_summary_params) 
      if @order_summary.save
        return success_response(@order_summary, :created)
      else
        render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity
      end
    end
    
    # when share with famliy member is true on address create
    def order_x2
      # @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
        if (@order&.address&.share_with_family_member == true)
          @order.update(quantity: 2)
          @order.amount = (@order.amount * 2)
          @order.sub_total = (@order.sub_total * 2)
          @order.tax_charges = (@order.tax_charges.to_i * 2)
          @order.delivery_charges = (@order.delivery_charges.to_i * 2)
          @order.save
          render json: BxBlockOrderManagement::OrderSerializer.new(@order).serializable_hash, status: :ok
        else
          @order.update(quantity: 1)
          @order.amount = (@order.amount / 2)
          @order.sub_total = (@order.sub_total / 2)
          @order.tax_charges = (@order.tax_charges.to_i / 2)
          @order.delivery_charges = (@order.delivery_charges.to_i / 2)
          @order.save
          render json: BxBlockOrderManagement::OrderSerializer.new(@order).serializable_hash, status: :ok
        end
      else
         render json: { message: "order not present", status: 422 }, status: :unprocessable_entity
      end
    end

    def get_order_details
      # @order_details = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
        render json: BxBlockOrderManagement::OrderSerializer.new(@order).serializable_hash, status: :ok
      else
        render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity
      end
    end

    def update_quantity
      # @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      get_delivery_charge = @order.delivery_charges.to_i
      if @order.present?
        if @order.coupon_code_id.present?
          coupon = BxBlockDiscountsoffers::Offer.find_by(id: @order.coupon_code_id)
          calc_total = params[:amount].to_i * params[:quantity].to_i 
          get_taxes = ((params[:amount].to_i * params[:quantity].to_i) * 18 / 100) 

          if calc_total > coupon.min_cart_value
            discount = coupon.discount_type == "percentage" ? ((calc_total * coupon.discount) / 100) : coupon_code.discount # 4400 * 25.0 / 100 
            sb_total = calc_total - discount
            @order.update(sub_total: sb_total + get_delivery_charge  + get_taxes)
            @order.update(quantity: params[:quantity])
            @order.update(tax_charges: get_taxes)
            @order.update(applied_discount: discount)

            render json: { quantity: @order.quantity, sub_total: @order.sub_total, applied_discount: @order.applied_discount, tax_charges: @order.tax_charges }
          else
            @order.update(coupon_code_id: nil)
            @order.update(applied_discount: 0.0)
            @order.quantity = params[:quantity]
            @order.update(tax_charges: get_taxes)
            calc_total = (params[:amount].to_i * params[:quantity].to_i + get_delivery_charge + get_taxes)
            @order.sub_total = calc_total.to_d
            @order.save
  
            render json: { quantity: @order.quantity, sub_total: @order.sub_total, applied_discount: @order.applied_discount, tax_charges: @order.tax_charges }
          end
        else
          get_taxes = ((params[:amount].to_i * params[:quantity].to_i) * 18 / 100)
          calc_total = ((params[:amount].to_i * params[:quantity].to_i) + get_taxes + get_delivery_charge)

          @order.quantity = params[:quantity]
          @order.sub_total = calc_total.to_d
          @order.tax_charges = get_taxes
          @order.save
  
          render json: { quantity: @order.quantity, sub_total: @order.sub_total, applied_discount: @order.applied_discount, tax_charges: @order.tax_charges }
        end
      else
        render json: { message: "Order not found with this id", status: 422 }, status: :unprocessable_entity
      end
    end
    
    def add_gift_note
      # @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
        @order.update(gift_note: params[:gift_note])
        render json: BxBlockOrderManagement::OrderSerializer.new(@order).serializable_hash, status: :ok
      else
        render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity    
      end
    end

    def create_subtotal
      # @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
        order_price = @order.price
        get_delivery_charge = BxBlockBook::DeliveryCharge.first.charge
        subtotal = order_price + get_delivery_charge

        render json: { subtotal: subtotal, status: 200 }, status: :ok
      else
        render json: { message: "not order found with this id", status: 404 }, status: :not_found
      end
    end

    def get_book_url_details
      # @order_details = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
        render json: {data: [{book_url: @order.book_url},]}, status: :ok
      else
        render json: { message: "Please Enter Vaild Order Id"}, status: :unprocessable_entity
      end
    end

    private

    def check_order
       @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
    end

    def order_summary_params
      params.permit(:quantity, :gift_note, :discount_code, :order_subtotal, :book_id, :delivery_charge, :book_size, :cover_type, :order_total, :order_id)
    end

    def success_response(order_summary, status = 200)
      render json: BxBlockOrdersummary::OrderSummarySerializer.new(order_summary).
        serializable_hash,
        status: status
    end
  end
end

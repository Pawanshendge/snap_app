# frozen_string_literal: true

require 'digest'

module BxBlockPaymentRazorpay
  class RazorpaysController < BxBlockPaymentRazorpay::ApplicationController
    
    before_action :create_order_items, only: [:create]

    def create
      order = BxBlockOrderManagement::Order.find(params[:order_id])

      if order.present?
        puts "======================= started payment for order: #{order.id} ================"
        amount = (order.sub_total * 100 ).to_i
        receipt = Digest::MD5.hexdigest(order.order_number.to_s)
        begin
          puts "======================= creating payment for order: #{order.id} ================"
          razorpay_order = Payment.create(amount, 'INR', receipt)
          if razorpay_order.status == 'created'
            puts "======================= created payment for order: #{order.id} ================"
            order.update(razorpay_order_id: razorpay_order.id)
            # order.update(payment_status: 'paid')
            # order.update(placed_at: Time.now())
            #order.update(placed_at: Time.now + Time.zone_offset('IST'))
            order_status_id = BxBlockOrderManagement::OrderStatus.find_or_create_by(
              status: 'confirmed', event_name: 'confirm_order'
            )

            render json: BxBlockOrderManagement::OrderSerializer.new(order).serializable_hash,
                   status: :ok
          end
          # SystemMailer.order_create_info(order).deliver!
          # SystemMailer.payment_done_info(order).deliver!
        rescue Exception => e
          puts "======================= exception for creating payment for order: #{order.id} ================"
          order.update(payment_status: 'failed')

          SystemMailer.payment_failed_info(order).deliver!
          render json: { message: e }
        end
      else
        render json: { success: false, errors: 'Order Not Found.' },
               status: :not_found
      end
    end

    def order_details
      if params[:razorpay_order_id].present?
        begin
          details = Payment.order_details(params[:razorpay_order_id])

          render json: {
            success: true,
            details: OrderDetailsSerializer.new(details).serializable_hash
          }
        rescue Exception => e
          render json: { message: e }
        end
      else
        render json: { error: { message: 'order_number param required' } },
               status: :not_found
      end
    end

    def verify_signature
      #create record in transactions table
      begin 
        puts "======================= rezorpay verification process ================"
        verify_result = Payment.verify(
          params[:razorpay_order_id],
          params[:razorpay_payment_id],
          params[:razorpay_signature]
        )

        puts "======================= #{verify_result} ================"
        
        order = BxBlockOrderManagement::Order.find_by(razorpay_order_id: params[:razorpay_order_id])
        order.update(status: 'in_transit', payment_status: 'paid', placed_at: Time.now())

        orders_transaction = order.order_transaction
        
        if orders_transaction.present? 
          orders_transaction.update(status: 'in_transit',
                                   razorpay_payment_id: params[:razorpay_payment_id],
                                   razorpay_signature: params[:razorpay_signature]
                                  )
        end
        # SystemMailer.payment_verified_info(order, order.order_transaction).deliver!

        puts "======================= payment captured and updated in order ================"

        render json: { success: verify_result }, status: :ok

      rescue Exception => e
        puts "======================= Exception in capturing payment ================"
        render json: { message: e }
      end
    end

    def capture
      order = BxBlockOrderManagement::Order.find(params[:order_id])

      if order.present?
        amount = (order.sub_total.to_f * 100 )
        begin
          response = Payment.capture(params[:payment_id], amount)

          render json: CaptureResponseSerializer.new(response).serializable_hash, status: :ok
        rescue Exception => e
          render json: { message: e }
        end
      else
        render json: { success: false, errors: 'Order Not Found.' },
               status: :not_found
      end
    end

    private

    def create_order_items
      order = BxBlockOrderManagement::Order.find(params[:order_id])
      if order.present?
        @order_items = order.order_items.build(order_id: order.id, quantity: order.quantity, unit_price: order.base_price.to_f + order.delivery_charges.to_f + order.additional_price.to_f - order&.applied_discount.to_f)
        @order_items.save
      else
        render json: { success: false, errors: 'Order Not Found.' },
        status: :not_found
      end
    end
  end
end

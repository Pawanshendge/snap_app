module BxBlockOrderManagement
  class ShiprocketController < BxBlockOrderManagement::ApplicationController
    before_action :find_order, only: [:download_invoice, :create, :cancel_order, :get_order, :generate_manifest, :print_manifest, :generate_label, :generate_invoice, :return_order, :track_order]

    def create
      @response = []
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if (@order.address&.share_with_family_member == true)
        new_order_ids = []
        new_order = clone_order_and_address(@order)
        unless @order.ship_rocket_order_id.present?
          new_order_ids = [@order, new_order]
          new_order_ids.each do |order|
            if ship_rocket.authorize
              response = ship_rocket.post_order(order.id)
              json_response = JSON.parse(response)
              if json_response['errors'].present?
                @response << { error: request.referer, message: json_response['errors'].values.flatten.join(',') }
              else
                order.update_shipment_details(json_response)
                if order.order_items.present?
                  order.order_items.each do |order_item|
                    tracking = BxBlockOrderManagement::Tracking.find_or_create_by(date: DateTime.current, status: json_response['status'].to_s.downcase )
                    order_item.order_trackings.create(tracking_id: tracking.id)
                  end
                end
                 SystemMailer.order_placed_info(order, json_response).deliver!
                @response << { reponse: json_response, message: request.referer, notice: 'Shipping request has been sent to ShipRocket successfully.' }
              end
            else
              return shiprocket_error_response(request)
            end
          end
        end
      else
        puts "======================= create shiprocket order api ================"
        if ship_rocket.authorize
          puts "======================= loged in into shiprocket ================"
          response = ship_rocket.post_order(@order.id)
          json_response = JSON.parse(response)
          if json_response['errors'].present?
            @response << { error: request.referer, message: json_response['errors'].values.flatten.join(',') }
          else
            puts "======================= shiprocket order created ================"
            @order.update_shipment_details(json_response)
            puts "======================= updated shipment details in shiprocket ================"
            if @order.order_items.present?
              @order.order_items.each do |order_item|
                tracking = BxBlockOrderManagement::Tracking.find_or_create_by(date: DateTime.current, status: json_response['status'].to_s.downcase )
                order_item.order_trackings.create(tracking_id: tracking.id)
              end
            end
            SystemMailer.order_placed_info(@order, json_response).deliver!
            @response << { reponse: json_response, message: request.referer, notice: 'Shipping request has been sent to ShipRocket successfully.' }
          end
        else
          puts "======================= Got error from shiprocket ================"
          return shiprocket_error_response(request)
        end
      end
      render json: { response: @response.blank? ? @response << { notice: 'Order already in system Shipping request was sent to ShipRocket successfully.'} : @response }
    end

    def cancel_order
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.cancel_order(@order.id)
        json_response = JSON.parse(response)
        if json_response['errors'].present?
          render json: { error: request.referer, message: json_response['errors'].values.flatten.join(','), status: 422 }, status: :unprocessable_entity
        else
          order.update_shipment_details(json_response)
          SystemMailer.order_canceled_info(order, json_response).deliver!
          render json: { message: json_response["message"], status: json_response["status_code"] }
        end
      else
        shiprocket_error_response(request)
      end
    end

    def get_order
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.get_order(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def generate_manifest
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.generate_manifest(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def print_manifest
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.print_manifest(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def generate_label
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.generate_label(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def generate_invoice
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.generate_invoice(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def download_invoice
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.generate_invoice(@order.id)
        response_data = JSON.parse(response)
        file = URI.open(response_data['invoice_url'])
        # data = File.read(file, encoding: 'ASCII-8BIT')
        send_data(file, :disposition => "inline", :type => "application/pdf")
      else
        shiprocket_error_response(request)
      end
    end

    def return_order
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.return_order(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    def track_order
      ship_rocket = BxBlockOrderManagement::Shiprocket.new
      if ship_rocket.authorize
        response = ship_rocket.track_order(@order.id)
        shiprocket_json_response(response)
      else
        shiprocket_error_response(request)
      end
    end

    private

    def find_order
      @order = BxBlockOrderManagement::Order.find_by(id: params[:id])
      unless @order.present?
        render json: {
          status: 404,
          message: 'Order not found with this id'
        }, status: :not_found
      end
    end

    def shiprocket_error_response(request)
      render json: { message: request.referer, notice: 'Something went wrong, while shiping with Ship Rocket' }
    end

    def shiprocket_json_response(response)
      json_response = JSON.parse(response)
      if json_response['errors'].present?
        render json: { error: request.referer, message: json_response['errors'].values.flatten.join(','), status: 422 },
                     status: :unprocessable_entity
      else
        render json: { message: json_response }
      end
    end

    def clone_order_and_address(order)
      if order.order_child_id.eql?(nil)
        @order.order_child_id = @order.id
        @order.quantity = 1
        @order.amount = (@order.amount / 2)
        @order.sub_total = (@order.sub_total / 2)
        @order.tax_charges = (@order.tax_charges.to_f/ 2)
        @order.delivery_charges = (@order.delivery_charges.to_i / 2)
        @order.additional_pages = (@order.additional_pages.to_i / 2)
        @order.additional_price = (@order.additional_price.to_i / 2)
        @order.total = (@order.total.to_f / 2)
        @order.base_price = (@order.base_price.to_i / 2)
        @order.applied_discount = (@order&.applied_discount.to_i / 2)
        @order.save
        new_order = @order.dup
        new_order.order_child_id = @order.id 
        new_order.quantity = 1
        new_order.save
        address = @order.address.dup
        shared_address = @order.address.shared_address
        address.phone_number = shared_address.phone_number
        address.full_name = shared_address.full_name
        address.pincode = shared_address.pincode
        address.city = shared_address.city
        address.landmark = shared_address.landmark
        address.state = shared_address.state
        address.share_with_family_member = false
        address.address = shared_address.address1
        address.order_id = new_order.id
        address.save
        return new_order
      else
        return BxBlockOrderManagement::Order.where(order_child_id: order.id).last
      end
    end
  end
end

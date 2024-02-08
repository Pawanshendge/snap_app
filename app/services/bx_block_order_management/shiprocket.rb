
require "uri"
require "net/http"

module BxBlockOrderManagement
  class Shiprocket
    attr_accessor :token
    # shiprocket_configuration = BxBlockApiConfiguration::ApiConfiguration.find_by(configuration_type: 'shiprocket')
    SHIP_ROCKET_BASE_URL = "https://apiv2.shiprocket.in/v1/"
    # SHIP_ROCKET_USER_EMAIL = shiprocket_configuration&.ship_rocket_user_email
    # SHIP_ROCKET_USER_PASSWORD = shiprocket_configuration&.ship_rocket_user_password

    def authorize
      begin

        puts '=======================start authorize shiprocket================'
        url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/auth/login")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/json"

        request.body = {
          "email"=> ENV['SHIP_ROCKET_USER_EMAIL'],
          "password"=> ENV['SHIP_ROCKET_USER_PASSWORD']
        }.to_json

        response = https.request(request)
        @token = JSON.parse(response.body)['token']

        puts '======================= got token ================'

        # Get pickup location
        url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/settings/company/pickup")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@token}"
        pickup_location_response = https.request(request)
        Rails.logger.info '======================= got pickup location ================'
        puts '======================= got pickup location ================'
        @pickup_location = JSON.parse(pickup_location_response.body)['data']['shipping_address'][0]['pickup_location']
      rescue
        @token = nil
      end
    end

    def post_order(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      puts "======================= fetch snaps order #{@order.id}================"
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/orders/create/adhoc")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      puts "======================= fetch snaps order #{@order.id}================"
      request.body =  formated_body_data(@order)
      puts "======================= created orders data for shiprocket ================"
      response = https.request(request)
      puts "======================= shiprocket order #{response.read_body} ================"
      response.read_body
    end

    def cancel_order(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/orders/cancel")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = {
        "ids"=> [@order.ship_rocket_order_id]
      }.to_json
      response = https.request(request)
      response.read_body
    end

    def get_order(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/orders/show/#{@order.ship_rocket_order_id}")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      response = https.request(request)
      response.read_body
    end

    def generate_manifest(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/manifests/generate/")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = {
        "shipment_id"=> [@order.ship_rocket_shipment_id]
      }.to_json
      response = https.request(request)
      response.read_body
    end

    def print_manifest(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/manifests/print")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = {
        "order_ids"=> [@order.ship_rocket_order_id]
      }.to_json
      response = https.request(request)
      response.read_body
    end


    def generate_label(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/courier/generate/label/")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = {
        "shipment_id"=> [@order.ship_rocket_shipment_id]
      }.to_json
      response = https.request(request)
      response.read_body
    end

    def generate_invoice(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/orders/print/invoice/")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@token}"
      request.body = {
        "ids"=> [@order.ship_rocket_order_id]
      }.to_json
      response = https.request(request)
      response.read_body
    end

    def return_order(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/orders/create/return/")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{token}"
      request.body =  return_order_data(@order)
      response = https.request(request)
      response.read_body
    end


    def track_order(order_id)
      @order = BxBlockOrderManagement::Order.find_by(id: order_id)      
      url = URI("#{SHIP_ROCKET_BASE_URL}"+"external/courier/track/shipment/#{@order.ship_rocket_shipment_id}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["Content-Type"] = "application/json"     
      request["Authorization"] = "Bearer #{token}"
      response = https.request(request)
      response.read_body
    end

    private

    def order_items(order)
      items = []
      items << {"name"=> order&.book_title || "Album Book", "sku"=>"#{order.id}-#{order.order_number}", "units"=> order.quantity.present? ? order.quantity : '',"tax"=> "18","selling_price"=> order.sub_total.to_f}
      items
    end


    def formated_body_data(order)
      @order = order
      @delivery_address = @order.address
    
      {"order_id" => @order.id.to_s,
       "order_date" => @order.created_at.strftime('%Y-%m-%d %I:%M'),
       "pickup_location" => @pickup_location,
       "channel_id" => "Custom",
       "billing_customer_name" => @order&.address&.full_name.to_s,
       "billing_last_name" => @order&.address&.full_name.to_s,
       "billing_address" => @delivery_address&.address,
       "billing_city" => @delivery_address&.city,
       "billing_pincode" => @delivery_address&.pincode,
       "billing_state" => @delivery_address&.state,
       "billing_country" => "india",
       "billing_email" => @delivery_address&.email_address,
       "billing_phone" => @delivery_address&.phone_number,
       "shipping_is_billing" => true,
       "shipping_address" => @delivery_address&.address,
       "shipping_address_2" => @shipping_address&.address_line_2,
       "shipping_city" => @delivery_address&.city,
       "shipping_pincode" => @delivery_address&.pincode,
       "shipping_country" => "india",
       "shipping_state" => @delivery_address&.state,
       "shipping_email" => @delivery_address&.email_address,
       "shipping_phone" => @delivery_address&.phone_number,
       "order_items" => order_items(@order),
       "payment_method" => "prepaid",
       "shipping_charges" => @order.shipping_total,
       "total_discount" => @order.applied_discount,
       "sub_total" => @order.sub_total.to_f + @order&.applied_discount.to_f,
       "length" => "10",
       "breadth" => "10",
       "height" => "10",
       "weight" => "10",
      }.to_json
    end

    def return_order_data(order)
      @order = order
      @delivery_address = @order.address

      {
        "order_id"=>@order.ship_rocket_order_id.to_s,
        "order_date"=>@order.created_at.strftime('%Y-%m-%d %I:%M'),
        "channel_id"=>"Custom",
        "pickup_customer_name"=> @order&.address&.full_name.to_s,
        "pickup_last_name"=> @order&.address&.full_name.to_s,
        "pickup_address"=> @delivery_address&.address,
        "pickup_address_2"=> "assasa",
        "pickup_city"=> @delivery_address&.city,
        "pickup_state"=> @delivery_address&.state,
        "pickup_country"=> "India",
        "pickup_pincode"=> @delivery_address&.pincode,
        "pickup_email"=> @delivery_address.email_address,
        "pickup_phone"=> @delivery_address&.phone_number,
        "pickup_isd_code"=> "91",
        "shipping_customer_name"=> @order&.address&.full_name.to_s,
        "shipping_last_name"=> @order&.address&.full_name.to_s,
        "shipping_address"=> "Castle",
        "shipping_address_2"=> "Bridge",
        "shipping_city"=> "ghaziabad",
        "shipping_country"=> "India",
        "shipping_pincode"=> 201005,
        "shipping_state"=> "Uttarpardesh",
        "shipping_email"=> "kumar.abhishek@shiprocket.com",
        "shipping_isd_code"=> "91",
        "shipping_phone"=> 8888888888,
        "order_items"=> order_items(@order),
        "payment_method"=> "PREPAID",
        "total_discount"=>@order.applied_discount,
        "sub_total" => @order.sub_total.to_f + @order&.applied_discount.to_f,
        "length"=> 11,
        "breadth"=> 11,
        "height"=> 11,
        "weight"=> 0.5
      }.to_json
    end

    def shipping_and_billing_same?(address)
      address&.address_for.to_s.include?('billing_and_shipping')
    end
  end
end

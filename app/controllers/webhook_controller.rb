class WebhookController < ApplicationController
  before_action :fetch_order, only: [:receive, :send_order_update_info_to_user]

  def receive
    return render json: { message: "order not found" } if @order.nil?
    @order.ship_rocket_awb_code  = params["awb"]
    @order.ship_rocket_status = params["current_status"].downcase
    @order.ship_rocket_order_id = params["order_id"]
    @order.status = params["shipment_status"].downcase
    @order.ship_rocket_shipment_id = params["shipment_status_id"]
    @order.updated_at = params["current_timestamp"]
    @order.ship_rocket_status_code = params["current_status_id"]
    @order.updated_at = Time.now
    @order.save

    send_order_update_info_to_user
  end

  def send_order_update_info_to_user
    SystemMailer.send_order_update_info(@order).deliver!
  end

  private

  def fetch_order
    @order = BxBlockOrderManagement::Order.find_by(ship_rocket_order_id: params[:order_id])
  end
end

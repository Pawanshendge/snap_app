module BxBlockOrderManagement
  class WebhookController < ApplicationController
    def shiprocket_order_updates
      puts "#{params["awb"]}"
    end
  end
end

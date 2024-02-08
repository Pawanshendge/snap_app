module BxBlockPaymentRazorpay
  class Payment
    class << self
      def create(amount, currency, receipt)
        Razorpay::Order.create(amount: amount, currency: currency, receipt: receipt)
      end

      def verify(order_id, payment_id, signature)
        payment_response = {
          razorpay_order_id: order_id,
          razorpay_payment_id: payment_id,
          razorpay_signature: signature
        }

        Razorpay::Utility.verify_payment_signature(payment_response)
      end

      def capture(payment_id, capture_amount, currency = 'INR')
        Razorpay::Payment.fetch(payment_id).capture(
          amount: capture_amount,
          currency: currency
        )
      end

      def order_details(order_id)
        Razorpay::Order.fetch(order_id)
      end
    end
  end
end

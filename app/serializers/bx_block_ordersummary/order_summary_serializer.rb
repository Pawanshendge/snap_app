module BxBlockOrdersummary
  class OrderSummarySerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :quantity,
      :gift_note,
      :discount_code,
      :order_subtotal,
      :book_id,
      :delivery_charge,
      :book_size,
      :cover_type,
      :order_total,
      :created_at,
      :updated_at
    ]
  end
end

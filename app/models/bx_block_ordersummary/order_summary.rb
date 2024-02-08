module BxBlockOrdersummary
  class OrderSummary < BxBlockOrdersummary::ApplicationRecord
    self.table_name = :order_summaries
    
    belongs_to :order, class_name: "BxBlockOrderManagement::Order"
  end
end

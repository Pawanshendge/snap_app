module BxBlockOrderManagement
  class SendDraftOrderMailWorker
    include Sidekiq::Worker

    def perform(order_id)
      order = BxBlockOrderManagement::Order.find_by(id: order_id)
      account = order.account
      if order.draft?
        DraftMailer.draft_email(order).deliver!
      end
    end

  end
end

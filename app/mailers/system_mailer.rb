class SystemMailer < ApplicationMailer

  def order_create_info(order)  
    @order = order
    attachments.inline['i-1.png'] = File.read("#{Rails.root}/app/assets/images/i-1.png")
    attachments.inline['i-2.png'] = File.read("#{Rails.root}/app/assets/images/i-2.png")
    attachments.inline['image-3.jpeg'] = File.read("#{Rails.root}/app/assets/images/image-3.jpeg")
    attachments.inline['i-4.png'] = File.read("#{Rails.root}/app/assets/images/i-4.png")
    attachments.inline['i-5.png'] = File.read("#{Rails.root}/app/assets/images/i-5.png")
    attachments.inline['i-6.png'] = File.read("#{Rails.root}/app/assets/images/i-6.png")
    # attachments.inline['thumbnail.png'] = File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    send_mail(get_account_email_address(order), "Order Placed")
  end

  def payment_done_info(order)
    @order = order
    send_mail(get_account_email_address(order), "Payment requested for Order")
  end

  def payment_failed_info(order)
    @order = order
    send_mail(get_account_email_address(order), "Payment Failed for Order")
  end

  def order_placed_info(order, json_response)
    @order = order
    @book = BxBlockBook::Book.find_by(id: @order.book_id)
    attachments.inline['i-1.png'] = File.read("#{Rails.root}/app/assets/images/i-1.png")
    attachments.inline['i-2.png'] = File.read("#{Rails.root}/app/assets/images/i-2.png")
    # attachments.inline['image-3.jpeg'] = File.read("#{Rails.root}/app/assets/images/image-3.jpeg")
    attachments.inline['i-4.png'] = File.read("#{Rails.root}/app/assets/images/i-4.png")
    attachments.inline['i-5.png'] = File.read("#{Rails.root}/app/assets/images/i-5.png")
    attachments.inline['i-6.png'] = File.read("#{Rails.root}/app/assets/images/i-6.png")
    attachments.inline['thumbnail.png'] = @book&.cover_image&.attached? ? AccountBlock::DocxDownloadService.new(@book&.cover_image).doc : File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    # attachments.inline['thumbnail.png'] = @book&.cover_image.attached? ? File.read(ActiveStorage::Blob.service.send(:path_for, @book&.cover_image.key)) : File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    # attachments.inline['thumbnail.png'] = File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    @json_response = json_response
    send_mail(get_account_email_address(order), "Order Placed")
  end

  def order_canceled_info(order, json_response)
    @order = order
    @json_response = json_response
    send_mail(get_account_email_address(order), "Order Cancelled")
  end

  def payment_verified_info(order, order_transaction)
    @order = order
    @order_transaction = order_transaction
    send_mail(get_account_email_address(order), "Payment Verified")
  end

  def send_order_update_info(order)
    @order = order
    send_mail(get_account_email_address(order), "Order update Status")
  end

  def get_account_email_address(order)
    email = order&.account&.email
  end
end

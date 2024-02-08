class DraftMailer < ApplicationMailer
  def draft_email(order)
    @order = order
    @account = @order.account
    @book = BxBlockBook::Book.find_by(id: @order.book_id)
    @token = BuilderJsonWebToken.encode @account.id
    # attachments.inline['logo.jpg'] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
    attachments.inline['i-2.png'] = File.read("#{Rails.root}/app/assets/images/i-2.png")
    # attachments.inline['image-3.jpeg'] = File.read("#{Rails.root}/app/assets/images/image-3.jpeg")
    # attachments.inline['thumbnail.png'] = @book&.cover_image.present? ? File.read(ActiveStorage::Blob.service.send(:path_for, @book&.cover_image.key)) : File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    # attachments.inline['thumbnail.png'] = File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    attachments.inline['thumbnail.png'] = @book&.cover_image.attached? ? AccountBlock::DocxDownloadService.new(@book.cover_image).doc : File.read("#{Rails.root}/app/assets/images/thumbnail.png")
    attachments.inline['i-5.png'] = File.read("#{Rails.root}/app/assets/images/i-5.png")
    attachments.inline['i-6.png'] = File.read("#{Rails.root}/app/assets/images/i-6.png")
    attachments.inline['df-1.png'] = File.read("#{Rails.root}/app/assets/images/df-1.png")
    attachments.inline['df-2.png'] = File.read("#{Rails.root}/app/assets/images/df-2.png")
    attachments.inline['df-3.png'] = File.read("#{Rails.root}/app/assets/images/df-3.png")
    attachments.inline['df-4.png'] = File.read("#{Rails.root}/app/assets/images/df-4.png")
    mail(
        to: @account.email,
        from: "Whitebook <#{ENV['SMTP_USERNAME']}>",
        subject: 'Draft Email') do |format|
      format.html { render 'draft' }
    end
  end
end
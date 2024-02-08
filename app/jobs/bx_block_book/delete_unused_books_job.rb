class BxBlockBook::DeleteUnusedBooksJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info '=======================Job started================'
    books = BxBlockBook::Book.where(book_status: 'pending')#.where(created_at: (Time.now-1.day))
    books.each do |book|
      Rails.logger.info "=======================#{book.id}================"
      order = BxBlockOrderManagement::Order.find_by(book_id: book.id)
      book.destroy! if order.nil?
      Rails.logger.info "=======================Failed: #{book.errors.inspect}================"
    end
    Rails.logger.info '=======================Job completed================'
  end
end

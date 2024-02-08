require "mini_magick"
module BxBlockOrderManagement
  class AttachCompressedImagesWorker
    include Sidekiq::Worker

    def perform(book_id)
      book = BxBlockBook::Book.find_by(id: book_id)
      if book && book.images.attached?
        book.compressed_images.destroy_all
        book.images.each do |image|
          mini_image = MiniMagick::Image.open(image)
          dim = mini_image.dimensions.map{|d| d/10}
          mini_image.resize "#{dim.first}x#{dim.last}"
          file = File.binread(mini_image.tempfile)
          book.compressed_images.attach io: StringIO.open(file), filename: image.try(:blob).try(:filename).to_s, content_type: mini_image.mime_type
          book.compressed_images.last.update(width: image.width, height: image.height, index: image.index)
        end
      end
    end

  end
end

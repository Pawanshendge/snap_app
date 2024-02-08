module BxBlockGallery
  class Photo < ApplicationRecord
    self.table_name = :photos
    
    # include ActiveStorageSupport::SupportForBase64
    # has_many_base64_attached :images
    # has_many_attached :images
    # belongs_to :book, class_name: 'BxBlockBook::Book'
  end
end

module BxBlockBook
  class Book < BxBlockBook::ApplicationRecord
    self.table_name = :table_books
    belongs_to :account, class_name: 'AccountBlock::Account'

    # has_many :photos, class_name: 'BxBlockGallery::Photo', dependent: :destroy
    # accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true

    enum book_status: [:pending, :completed]
    has_many :invite_user, class_name: "BxBlockBook::InviteUser", dependent: :destroy
    
    include ActiveStorageSupport::SupportForBase64
    has_many_base64_attached :images
    has_many_base64_attached :compressed_images
    has_one_base64_attached :cover_image
    # validates :month, presence: true
    # validates :year, presence: true
    def test(image)
      "data:image/jpeg\;base64\,\ #{Base64.encode64(AccountBlock::DocxDownloadService.new(image).doc)}".delete "\n"
    end
  end
end

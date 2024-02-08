module BxBlockBook
  class Contribution < BxBlockBook::ApplicationRecord
    self.table_name = :contributions

    include ActiveStorageSupport::SupportForBase64
    has_many_base64_attached :images
  end
end

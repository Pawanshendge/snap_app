module AccountBlock
  class DashboardMediaFile < AccountBlock::ApplicationRecord
    self.table_name = :dashboard_media_files

    include ActiveStorageSupport::SupportForBase64
    has_one_base64_attached :media_file
  end
end

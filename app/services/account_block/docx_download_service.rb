require 'active_storage/downloading'
module AccountBlock
  class DocxDownloadService
    include ActiveStorage::Downloading
    attr_reader :blob

    def initialize(blob)
      @blob = blob
    end

    def doc
      download_blob_to_tempfile do |file|
        File.read(file)
      end
    end
  end
end

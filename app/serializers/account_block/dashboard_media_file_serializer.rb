module AccountBlock
  class DashboardMediaFileSerializer < BuilderBase::BaseSerializer
    attributes *[
      :name,
      :priority,
    ]
    
    attribute :media_file do |object, params|
      if object.media_file.attached?
        # Rails.application.routes.default_url_options[:host] + Rails.application.routes.url_helpers.rails_blob_path(object.media_file, only_path: true)
        ENV['HOST_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.media_file, only_path: true)
      end
    end
  end
end

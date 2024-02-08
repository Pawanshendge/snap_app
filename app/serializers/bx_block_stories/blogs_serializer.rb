module BxBlockStories
  class BlogsSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :description, :status, :title, :url

    attribute :blog_file do |object, params|
      if object&.blog_file.attached?
        ENV['HOST_URL'] + Rails.application.routes.url_helpers.rails_blob_url(object.blog_file, only_path: true)
      end
    end
  end
end

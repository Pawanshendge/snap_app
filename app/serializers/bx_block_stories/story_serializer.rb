module BxBlockStories
  class StorySerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :description, :valid_till, :active, :title, :story_type, :link

    attribute :story_file do |object, params|
      if object&.story_file.attached?
        ENV['HOST_URL'] + Rails.application.routes.url_helpers.rails_blob_url(object.story_file, only_path: true)
      end
    end
  end
end

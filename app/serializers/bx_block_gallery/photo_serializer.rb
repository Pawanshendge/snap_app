module BxBlockGallery
  class PhotoSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :month_year, :month_range, :title, :year, :month, :image_caption, :photo_type, :created_at

    attribute :images do |object, params|
      host = params[:host] || ''

      if object.images.attached?
        object.images.map { |image|
          {
            id: image.id,
            url: host + Rails.application.routes.url_helpers.rails_blob_url(
              image, only_path: true
            )
          }
        }
      end
    end

    attribute :length do |object|
      if object.images.attached?
        object.images.length
      end
    end
  end
end

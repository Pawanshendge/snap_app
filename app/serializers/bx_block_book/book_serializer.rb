module BxBlockBook
  class BookSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :year, :month, :images, :flag, :book_status, :book_title, :month_range, :month_year, :book_color, :title_layout, :total_pages, :cover_type, :paper_type, :spine_title, :title_color, :logo_color, :from_year, :from_month, :to_year, :to_month, :cover_image

    attribute :total_pages do |object, params|
      if object.images.attached?
        object.images.count
      end    
    end
   
    attribute :images do |object, params|
      @host = host

      if object.images.attached?
        object.images.order("index").map { |image|
          images_response(image)
        }
      end
    end

    attribute :compressed_images do |object, params|
      @host = host

      if object.compressed_images.attached?
        object.compressed_images.order("index").map { |image|
          images_response(image)
        }
      end
    end

     attribute :cover_image do |object|
      @host = host
        if object.cover_image.present?
          img = object.cover_image
            {
              file_name: img.try(:blob).try(:filename),
              content_type: img.try(:blob).try(:content_type),
              id: img.id,
              url: img.service_url.split('?').first, only_path: true,
              width: img.width,
              height: img.height,
              dpi: img.dpi,
              crop_x: img.crop_x,
              crop_y: img.crop_y,
              cropWidth: img.crop_width,
              cropHeight: img.crop_height,
              created_date: img.created_at,
              show_date: img.show_date,
              image_date: img.image_date,
              image_caption: img.image_caption,
              face_position: img.face_position,
            }
        end
    end

    attributes :book_title do |object|
      if object.present?
        if object.book_title.present?
          object.book_title
        else
          "#{object&.month} #{object&.year}"
        end
      else
        ''
      end
    end

    class << self
      private

      def images_response(image)
        {
          file_name: image.try(:blob).try(:filename),
          content_type: image.try(:blob).try(:content_type),
          id: image.id,
          url: image.service_url.split('?').first, only_path: true,
          image_type: image.image_type,
          image_caption: image.image_caption,
          is_cover: image.is_cover,
          width: image.width,
          height: image.height,
          dpi: image.dpi,
          index: image.index,
          crop_x: image.crop_x,
          crop_y: image.crop_y,
          cropWidth: image.crop_width,
          cropHeight: image.crop_height,
          created_date: image.created_at,
          show_date: image.show_date,
          image_date: image.image_date,
          face_position: image.face_position,
        }
      end

      def host
        Rails.env.development? ? 'http://localhost:3000' : 'https://snapslikeapp2-89023-ruby.b89023.dev.eastus.az.svc.builder.cafe'
      end
    end

  end
end

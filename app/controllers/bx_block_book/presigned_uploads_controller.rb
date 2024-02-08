module BxBlockBook
  class PresignedUploadsController < BxBlockBook::ApplicationController

    def create
      data = []
      params[:images].each do |image_params|
        create_blob(image_params)
         data << {
          url: @blob.service_url_for_direct_upload(expires_in: 90.minutes),
          headers: @blob.service_headers_for_direct_upload,
          signed_id: @blob.signed_id,
          index: image_params[:index]
        }
      end
      render json: { data: do_sort(data)}
    end 

    private

    def do_sort(data)
      data.sort {|first, second| first[:index] <=> second[:index]}
    end
  
    def create_blob(image_params)
      @blob = ActiveStorage::Blob.create_before_direct_upload!(
        filename: image_params[:filename],
        byte_size: image_params[:byte_size],
        checksum: image_params[:checksum],
        content_type: image_params[:content_type]
      )
    end
    
    def blob_params
      params.permit(:filename, :byte_size, :checksum, :content_type)
    end
  end
end

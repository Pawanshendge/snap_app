module BxBlockGallery
  class PhotosController < ApplicationController
    before_action :find_photo, only: [:destroy, :update, :show]

    include ErrorHandler

    def create
      @photos = BxBlockGallery::Photo.new(photos_params)
      @photos.book_id = params[:book_id]  

      if @photos.save
        render json: BxBlockGallery::PhotoSerializer.new(@photos).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@photos.errors)
        }, status: :unprocessable_entity
      end
    end

    def index
      @photos = BxBlockGallery::Photo.all

      if @photos.present?
        render json: BxBlockGallery::PhotoSerializer.new(@photos, meta: {
          message: "Photos List"
        }).serializable_hash, status: :ok
      else
        render json:{meta: {message: "Record not found."}}
      end
    end

    def show
      if photo.present?
        render json: BxBlockGallery::PhotoSerializer.new(photo, meta: {
          message: "here is the Photo with the given id"
        }).serializable_hash, status: :ok
      else
        render json:{ message: "Record not found.", status: 404 }, status: :not_found 
      end
    end

    def update
      if @photo.update(photos_params)
        render json: BxBlockGallery::PhotoSerializer.new(@photo).serializable_hash, status: 200
      else
        render json: {
          errors: [{
            message: 'Invalid data format',
          }],
        }, status: :unprocessable_entity
      end
    end

    def destroy
      if @photo.destroy
        render json: { message: "Photo destroyed successfully" }, status: 200
      else
        return error_response(@photo)
      end
    end

    private
    
    def find_photo
      @photo = BxBlockGallery::Photo.find_by(id: params[:id])
      render json: { message: "Invalid Photo id" }, status: 422 and return unless @photo.present?
    end

    def current_user
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def photos_params
      params.permit(:month_year, :month_range, :title, :year, :month, :image_caption, :photo_type, photos_attributes: [:image])
    end

    def error_response(photo)
      render json: {
        errors: format_activerecord_errors(photo.errors)
      },
      status: :unprocessable_entity
    end
  end
end

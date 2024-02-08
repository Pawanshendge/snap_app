module BxBlockGallery
  class PhotoValidation
    include ActiveModel::Validations
    attr_reader :month, :year, :images
    validate :custom_validate
    validate :check_images
    
    def initialize(params)
      @month = params["month"]
      @year = params["year"]
      @images = params["images"]
    end

    def custom_validate
      errors.add :month, 'Month must be present' if @month.blank?
      # errors.add :images, 'Only JPEG, JPG and PNG file extensions are allowed.' unless [".jpeg", ".jpg", ".png"].include?(File.extname(@images)) if @images.present?
      errors.add :year, 'Year must be present' if @year.blank?
      errors.add :images, "cannot upload more than 20 images" if @images.length > 20
    end

    def check_images
      photo_count = BxBlockGallery::Photo.find_by(year: @year, month: @month)&.images&.count
      errors.add :message, "Already 20 images present with this year and month please select other month or year" and return if photo_count == 20
    end
  end
end
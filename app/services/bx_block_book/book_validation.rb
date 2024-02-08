module BxBlockBook
  class BookValidation
    require 'date'
    
    include ActiveModel::Validations
    attr_reader :month, :year
    # validate :custom_validate
    # validate :check_presence_of_month_and_year_book    

    def initialize(params)
      @month = params["month"]
      @year = params["year"]
      @images = params["images"]
    end

    # def custom_validate
      # errors.add :month, 'Month must be present' if @month.blank?
      # errors.add :month, 'Month name is not valid' unless (Date::MONTHNAMES.compact).include?(@month)
      # errors.add :images, "please upload minimum 20 images and maximum 30 images" if (@images&.count < 20 || @images&.count > 30) if @images.present?
    # end

    # def check_presence_of_month_and_year_book
    #   book = BxBlockBook::Book.find_by(month: @month, year: @year)
    #   if book.present?
    #     errors.add(:message, "book is already present with this year and month")
    #   end
    # end
  end
end
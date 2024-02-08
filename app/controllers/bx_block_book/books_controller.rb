# module BxBlockBook
#   require('zip')
#   class BooksController < BxBlockBook::ApplicationController
#     before_action :find_book, only: [:show, :destroy, :share_book, :edit, :add_a_different_photo, :replace_images, :book_update_new, :download_pdf, :bulk_download, :bulk_download_zip]
#     before_action :check_order, only: [:download_order]

#     include ErrorHandler
#     include BuilderJsonWebToken::JsonWebTokenValidation
#     before_action :validate_json_web_token, only: [:start_contributing_images, :delete_contributed_images, :get_user_link]

#     def download_pdf
#       respond_to do |format|
#         format.pdf do
#           render pdf: "PhotoBook #{@book}", :page_height => '8in', :page_width => '8in', template: 'photo_book.html.erb', disposition: 'attachment'
#         end
#       end
#     end

#     def download_order
#       book = BxBlockBook::Book.find_by(id: @order.book_id)
#       respond_to do |format|
#         format.pdf do
#           render pdf: "Order #{@order}",:page_height => '8in', :page_width => '8in', template: 'order.html.erb', disposition: 'attachment', locals: { book: book }
#         end
#       end
#     end

#     def bulk_download_zip
#       order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
#       zip_stream = Zip::OutputStream.write_buffer do |zip|
#         @book.images.each do |file|
#           # zip.put_next_entry("#{file.try(:blob).try(:filename)}")
#           zip.put_next_entry("#{file.id}.jpg")
#           zip.write(file.download)
#         end

#         # cover_image
#         if @book.cover_image.present?
#           zip.put_next_entry("cover_image.jpg")
#           zip.write(@book.cover_image.download)
#         end

#         zip.put_next_entry "book_data/data.txt"
#         zip.puts "book_title => #{@book.book_title}", "logo_color => #{@book.logo_color}", 
#                  "spine_title => #{@book.spine_title}", "book_color => #{@book.book_color}", "title_color => #{@book.title_color}"
#         if order.present?
#            zip.puts "gift_note =>  #{order.gift_note}"
#         end

#         # caption file
#         zip.put_next_entry("image_caption.txt")
#         @book.images.collect{|img| zip.puts "#{img.try(:blob).try(:filename)}=>", "#{img.image_caption}" if img.image_caption.present?}.compact
#       end
#       # important - rewind the steam
#       zip_stream.rewind
#       send_data zip_stream.read,
#                 type: 'application/zip',
#                 disposition: 'attachment',
#                 filename: "book#{@book.id}.zip"
#     end

#     def show
#       return success_response(@book, :created)
#     end

#     def edit
#       return success_response(@book)
#     end

#     def upload_image_through_url
#       validator = BookValidation.new(params)
#       if validator.valid?
#         @book = Book.new(book_create_params)
#         require 'open-uri'
#         if params[:images].present?
#           params[:images].each do |image|
#             url = URI.parse(image["signed_id"])
#             filename = File.basename(url.path)
#             file = URI.open(url)
#             @book.images.attach(io: file, filename: filename)
#             @book.images.last.update(width: image["width"], height: image["height"], index: image["index"])
#           end
#         end
#         if @book.save
#           return success_response(@book, :created)
#         else
#           return error_response(@book)
#         end
#       else
#         render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
#       end
#     end
    
#     def create
#       validator = BookValidation.new(params)
#       if validator.valid?
#         @book = Book.new(book_create_params)
#         # @book.account_id = current_user.id
        
#         if params[:images].present?
#           params[:images].each do |image|
#             @book.images.attach(data: image)
#           end
#         end

#         if @book.save
#           return success_response(@book, :created)
#         else
#           return error_response(@book)
#         end
#       else
#         render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
#       end
#     end

#     def book_create
#       validator = BookValidation.new(params)
#       if validator.valid?
#         @book = Book.new(book_create_params)
#         # @book.account_id = current_user.id
        
#         if params[:images].present?
#           params[:images].each do |image|
#             @book.images.attach(image)
#           end
#         end

#         if @book.save
#           return success_response(@book, :created)
#         else
#           return error_response(@book)
#         end
#       else
#         render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
#       end
#     end

#     def book_create_new
#       validator = BookValidation.new(params)
#       if validator.valid?
#         @book = Book.create(book_create_params.merge(book_status: 'pending'))
#         if params[:images].present?
#           params[:images].each do |image|
#             @book.images.attach(image["signed_id"])
#             @book.images.last.update(width: image["width"], height: image["height"], index: image["index"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], face_position: image["face_position"], is_cover: true)
#           end
#         end

#         # if params[:cover_image].present?
#         #   params[:cover_image].each do |image|
#         #     @book.cover_image.attach(image["signed_id"])
#         #     @book.cover_image.update(width: image["width"], height: image["height"], dpi: image["dpi"], image_type: image["image_type"])
#         # end
#         if @book.images.attached?
#           @book.cover_image.attach(@book.images.last.blob)
#         end
#         return success_response(@book, :created)
#       else
#         render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
#       end
#     end

#     def update
#       @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
#       if @order.present?
#        if params[:book_title].present?
#         @book_title =  params[:book_title]
#        end
#        if params[:book_color].present?
#         @book_color = params[:book_color]
#        end
#        if params[:title_layout].present?
#         @title_layout = params[:title_layout]
#        end
#        @order.update(book_title: @book_title, book_color: @book_color, title_layout: @title_layout)
#      end
#       @book = BxBlockBook::Book.find_by(id: params[:id])
      
#       return render json: {errors: [
#           {book: 'Not found'},
#         ]}, status: :not_found if @book.blank?

#       if @book.update(book_update_params)
#         if params[:image_id].present?
#           other_images = @book.images.where.not(id: params[:image_id])
#           cover_image = ActiveStorage::Attachment.find_by(id: params[:image_id])
#           if cover_image
#             cover_image.update(is_cover: true)
#             other_images.update(is_cover: false)
#           end
#         end
#         return success_response(@book, :created)
#       else
#         return error_response(@book)
#       end
#     end

#     def replace_images
#       if params[:images].present?
#         params[:images].each do |image|
#           @photos = @book.images.where(id: nil)
#           if @photos.first.present?
#             @photos.first.update(data: image).attach
#           else
#             @book.images.attach(data: image)
#           end
#         end
#         render json: {message: "Images replaced successfully."}, status: 200
#       else
#         render json: {message: "Images not found."}, status: 200
#       end
#     end

#     def destroy
#       if @book.destroy
#         render json: { message: "Book destroyed successfully" }, status: 200
#       else
#         return error_response(@book)
#       end
#     end

#     def book_color
#       @book_colors = BxBlockBook::BookColor.all
#       if @book_colors.present?
#         render json: BxBlockBook::BookColorSerializer.new(@book_colors).serializable_hash, status: :ok
#       else
#         render json:{ message: "book colours not found.", status: 404 }, status: :not_found
#       end
#     end

#     def get_book_size_price
#       @book_size = BxBlockBook::Price.all
#       if @book_size.present?
#         render json: BxBlockBook::BookSizeSerializer.new(@book_size).serializable_hash, status: :ok
#       else
#         render json:{ message: "book size not found.", status: 404 }, status: :not_found
#       end
#     end

#     def get_image_limit
#       @image_limit = BxBlockBook::ImageLimit.all
#       if @image_limit.present?
#         render json: { data: @image_limit }
#       else
#         render json:{ message: "book Image limit Not Found.", status: 404 }, status: :not_found
#       end
#     end

#     def get_additional_price_per_page
#       @get_additional_price_per_page = BxBlockBook::AdditionalPricePerPage.first.additional_price
#       if @get_additional_price_per_page.present?
#         render json: { price_per_page: @get_additional_price_per_page }
#       else
#         render json:{ message: "additional price per page Not Found.", status: 404 }, status: :not_found
#       end
#     end

#     def get_delivery_charge
#       @delivery_charges = BxBlockBook::DeliveryCharge.all
#       if @delivery_charges.present?
#         render json: BxBlockBook::DeliveryChargeSerializer.new(@delivery_charges).serializable_hash, status: :ok
#       else
#         render json:{ message: "delivery charges not found.", status: 404 }, status: :not_found
#       end
#     end

#     def get_book_price
#       if (params[:cover_type] == 'hard cover' || params[:cover_type] == 'soft cover')
#         @price = BxBlockBook::Price.find_by(cover_type: params[:cover_type])
#         find_min_limit = BxBlockBook::Price.find_by(cover_type: params[:cover_type]).min_limit
#         find_additional_price_per_page = BxBlockBook::AdditionalPricePerPage.first.additional_price
      
#         if params[:no_of_pages].to_i > find_min_limit
#           additional_pages = params[:no_of_pages].to_i - find_min_limit
#           total = additional_pages.to_i * find_additional_price_per_page
#           total_price = total + @price.price

#           render json: { total_price: total_price, price: @price }
#         else
#           render json: { price: @price }
#         end
#       else
#         render json: { message: "this cover type not present", status: 404 }, status: :not_found
#       end
#     end

#     def add_a_different_photo
#       @book.images.attach(data: params[:image])
#       return success_response(@book, :created)
#     end
    
#     def shuffle_photos
#       @book = BxBlockBook::Book.find_by(id: params[:bookId])
#       attachment = ActiveStorage::Attachment.find_by(id: params["source"][:sourceId])
#       attachment.update(index: params["source"][:sourceIndex])
#       attachment1 = ActiveStorage::Attachment.find_by(id: params["destination"][:destinationId])
#       attachment1.update(index: params["destination"][:destinationIndex])
#       return success_response(@book)
#     end

#     def crop_photo
#       @book = BxBlockBook::Book.find_by(id: params[:bookId])
#       attachment = ActiveStorage::Attachment.find_by(id: params[:imageId])
#       attachment&.delete
#       if params[:images].present?
#         if params[:type] == 'book_image'
#           params[:images].each do |image|
#             @book.images.attach(data: image)
#           end
#           @book.images.last.update(index: params[:index], width: params[:width], height: params[:height], is_cover: params[:is_cover], image_caption: params[:image_caption], image_type: params[:image_type])
#         elsif params[:type] == 'book_cover'
#           params[:images].each do |image|
#             @book.cover_image.attach(data: image)
#           end
#           @book.cover_image.update(index: params[:index], width: params[:width], height: params[:height], is_cover: params[:is_cover], image_caption: params[:image_caption], image_type: params[:image_type])
#         end
#       end
      
#       return success_response(@book)  
#     end

#     def get_user_link
#       @id = validate_json_web_token
#       @account = AccountBlock::Account.find_by(id: @id.id)
#       if @account.present?
#         contribution = BxBlockBook::Contribution.create(user_id: @account.id, unique_identify_id: get_unique_identify_id, shared_link: @account.shared_link)
#         render json: { shared_link: @account.shared_link, unique_identify_id: contribution.unique_identify_id, status: 200 }, status: :ok
#       else
#         render json: { message: "Account not found", status: 404 }, status: :not_found
#       end
#     end

#     def start_contributing_images
#       @id = validate_json_web_token
#       @account = AccountBlock::Account.find_by(id: @id.id)
#       if @account.present?
#         @contribution = BxBlockBook::Contribution.find_by(shared_link: params[:shared_link])
#         @contribution.friend_id = @account.id
#         @contribution.save
#         if params[:images].present?
#           byebug
#           params[:images].each do |image|
#             @contribution.images.attach(data: image)
#           end
#         end
#         # render json: { contribution_data: @contribution, status: 200 }, status: :ok
#       render json: {data: BxBlockBook::ContributionSerializer.new(@contribution)}

#       else
#         render json: { message: "Account not found", status: 404 }, status: :not_found
#       end  
#     end

#     def get_contributed_images
#       @id = validate_json_web_token
#       @account = AccountBlock::Account.find_by(id: @id.id)
#       @contributed_images =  BxBlockBook::Contribution.where(shared_link: params[:shared_link])
#       render json: {data: BxBlockBook::ContributionSerializer.new(@contributed_images)}
#     end

#     def delete_contributed_images
      
#       @id = validate_json_web_token
#       @account = AccountBlock::Account.find_by(id: @id.id)
      
#       if @account.present?
#         params[:image_ids].each do |image|
#           attachment = ActiveStorage::Attachment.find_by(id: image).delete
#         end
#         render json: { message: "Attachment destroyed successfully" }, status: 200
#       else
#         render json: { message: "Account not found", status: 404 }, status: :not_found
#       end
#     end

#     def book_update_new
#       @orders = BxBlockOrderManagement::Order.where(book_id: @book.id)
#       if params[:images].present?
#         images_added = (params[:images].last[:index] + 1) > @book.images.count
#         params[:images].each do |image|
#           @book.images.attach(image["signed_id"])
#           @book.images.last.update(width: image["width"], height: image["height"], index: image["index"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], show_date: image["show_date"], image_caption: image["image_caption"], face_position: image["face_position"])
#         end

#         @orders.each do |order|
#           family_member = order&.address&.share_with_family_member #boolean values 
#           BxBlockOrderManagement::RemoveCoupon.new(order, {}).call if order.coupon_code_id && images_added
#           order.update_additional_page_price(@book&.images&.count&.to_i, family_member)
#         end
#       end
#       if params[:cover_image].present?
#         params[:cover_image].each do |image|
#           @book.cover_image.attach(image["signed_id"])
#           @book.cover_image.update(width: image["width"], height: image["height"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], show_date: image["show_date"], image_caption: image["image_caption"])
#         end
#       end
#       return success_response(@book)
#     end

#     private

#     def find_book
#       @book = Book.find_by(id: params[:id])
#       render json: { message: "Invalid Book id" }, status: 422 and return unless @book.present?
#     end

#     def book_create_params
#       params.permit(:month, :year, :spine_title, :cover_image, :from_year, :from_month, :to_year, :to_month)
#     end

#     def book_update_params
#       params.permit(:book_title, :month_range, :month_year, :book_color, :title_layout, :spine_title, :title_color, :logo_color, :cover_type, :cover_image, :from_year, :from_month, :to_year, :to_month, :month, :year)
#     end

#     def error_response(book)
#       render json: {
#         errors: format_activerecord_errors(book.errors)
#       },
#       status: :unprocessable_entity
#     end

#     def find_existing_book
#       begin
#         @book = BxBlockBook::Book.find_by(month: params[:month], year: params[:year])
#       rescue ActiveRecord::RecordNotFound => e
#         return render json: {errors: [
#           { book: 'Book Not Found' },
#         ]}, status: 404
#       end
#     end

#     def success_response(book, status = 200)
#       render json: BxBlockBook::BookSerializer.new(book).
#         serializable_hash,
#         status: status
#     end

#     def check_order
#       @order = BxBlockOrderManagement::Order.find_by(id: params[:id])
#     end

#     def get_unique_identify_id
#       o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
#       string = (0...5).map { o[rand(o.length)] }.join
#     end

#   end
# end



module BxBlockBook
  require('zip')
  class BooksController < BxBlockBook::ApplicationController
    before_action :find_book, only: [:show, :destroy, :share_book, :edit, :add_a_different_photo, :replace_images, :book_update_new, :download_pdf, :bulk_download, :bulk_download_zip]
    before_action :check_order, only: [:download_order]
    MESSAGE = "Account not found"
    include ErrorHandler
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: [:start_contributing_images, :delete_contributed_images, :get_user_link]

    def download_pdf
      respond_to do |format|
        format.pdf do
          render pdf: "PhotoBook #{@book}", :page_height => '8in', :page_width => '8in', template: 'photo_book.html.erb', disposition: 'attachment'
        end
      end
    end

    def download_order
      book = BxBlockBook::Book.find_by(id: @order.book_id)
      respond_to do |format|
        format.pdf do
          render pdf: "Order #{@order}",:page_height => '8in', :page_width => '8in', template: 'order.html.erb', disposition: 'attachment', locals: { book: book }
        end
      end
    end

    def bulk_download_zip
      order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      zip_stream = Zip::OutputStream.write_buffer do |zip|
        @book.images.each do |file|
          # zip.put_next_entry("#{file.try(:blob).try(:filename)}")
          zip.put_next_entry("#{file.id}.jpg")
          zip.write(file.download)
        end

        # cover_image
        if @book.cover_image.present?
          zip.put_next_entry("cover_image.jpg")
          zip.write(@book.cover_image.download)
        end

        zip.put_next_entry "book_data/data.txt"
        zip.puts "book_title => #{@book.book_title}", "logo_color => #{@book.logo_color}", 
                 "spine_title => #{@book.spine_title}", "book_color => #{@book.book_color}", "title_color => #{@book.title_color}"
        if order.present?
           zip.puts "gift_note =>  #{order.gift_note}"
        end

        # caption file
        zip.put_next_entry("image_caption.txt")
        @book.images.collect{|img| zip.puts "#{img.try(:blob).try(:filename)}=>", "#{img.image_caption}" if img.image_caption.present?}.compact
      end
      # important - rewind the steam
      zip_stream.rewind
      send_data zip_stream.read,
                type: 'application/zip',
                disposition: 'attachment',
                filename: "book#{@book.id}.zip"
    end

    def show
      return success_response(@book, :created)
    end

    def edit
      return success_response(@book)
    end

    def upload_image_through_url
      validator = BookValidation.new(params)
      if validator.valid?
        @book = Book.new(book_create_params)
        require 'open-uri'
        if params[:images].present?
          params[:images].each do |image|
            url = URI.parse(image["signed_id"])
            filename = File.basename(url.path)
            file = URI.open(url)
            @book.images.attach(io: file, filename: filename)
            @book.images.last.update(width: image["width"], height: image["height"], index: image["index"])
          end
        end
        if @book.save
          return success_response(@book, :created)
        else
          return error_response(@book)
        end
      else
        render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
      end
    end
    
    def create
      validator = BookValidation.new(params)
      if validator.valid?
        @book = Book.new(book_create_params)
        # @book.account_id = current_user.id
        if params[:images].present?
          params[:images].each do |image|
            @book.images.attach(data: image)
          end
        end

        if @book.save
          return success_response(@book, :created)
        else
          return error_response(@book)
        end
      else
        render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
      end
    end

    def book_create
      validator = BookValidation.new(params)
      if validator.valid?
        @book = Book.new(book_create_params)
        # @book.account_id = current_user.id
        
        if params[:images].present?
          params[:images].each do |image|
            @book.images.attach(image)
          end
        end

        if @book.save
          return success_response(@book, :created)
        else
          return error_response(@book)
        end
      else
        render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
      end
    end

    def book_create_new
      validator = BookValidation.new(params)
      if validator.valid?
        @book = Book.create(book_create_params.merge(book_status: 'pending'))
        if params[:images].present?
          params[:images].each do |image|
            @book.images.attach(image["signed_id"])
            @book.images.last.update(width: image["width"], height: image["height"], index: image["index"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], face_position: image["face_position"], is_cover: true)
          end
        end

        # if params[:cover_image].present?
        #   params[:cover_image].each do |image|
        #     @book.cover_image.attach(image["signed_id"])
        #     @book.cover_image.update(width: image["width"], height: image["height"], dpi: image["dpi"], image_type: image["image_type"])
        # end
        if @book.images.attached?
          @book.cover_image.attach(@book.images.last.blob)
        end
        return success_response(@book, :created)
      else
        render json: { errors: validator.errors, status: 422 }, status: :unprocessable_entity
      end
    end

    def update
      @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if @order.present?
       if params[:book_title].present?
        @book_title =  params[:book_title]
       end
       if params[:book_color].present?
        @book_color = params[:book_color]
       end
       if params[:title_layout].present?
        @title_layout = params[:title_layout]
       end
       @order.update(book_title: @book_title, book_color: @book_color, title_layout: @title_layout)
     end
      @book = BxBlockBook::Book.find_by(id: params[:id])
      
      return render json: {errors: [
          {book: 'Not found'},
        ]}, status: :not_found if @book.blank?

      if @book.update(book_update_params)
        if params[:image_id].present?
          other_images = @book.images.where.not(id: params[:image_id])
          cover_image = ActiveStorage::Attachment.find_by(id: params[:image_id])
          if cover_image
            cover_image.update(is_cover: true)
            other_images.update(is_cover: false)
          end
        end
        return success_response(@book, :created)
      else
        return error_response(@book)
      end
    end

    def replace_images
      if params[:images].present?
        params[:images].each do |image|
          @photos = @book.images.where(id: nil)
          if @photos.first.present?
            @photos.first.update(data: image).attach
          else
            @book.images.attach(data: image)
          end
        end
        render json: {message: "Images replaced successfully."}, status: 200
      else
        render json: {message: "Images not found."}, status: 200
      end
    end

    def destroy
      if @book.destroy
        render json: { message: "Book destroyed successfully" }, status: 200
      else
        return error_response(@book)
      end
    end

    def book_color
      @book_colors = BxBlockBook::BookColor.all
      if @book_colors.present?
        render json: BxBlockBook::BookColorSerializer.new(@book_colors).serializable_hash, status: :ok
      else
        render json:{ message: "book colours not found.", status: 404 }, status: :not_found
      end
    end

    def get_book_size_price
      @book_size = BxBlockBook::Price.all
      if @book_size.present?
        render json: BxBlockBook::BookSizeSerializer.new(@book_size).serializable_hash, status: :ok
      else
        render json:{ message: "book size not found.", status: 404 }, status: :not_found
      end
    end

    def get_image_limit
      @image_limit = BxBlockBook::ImageLimit.all
      if @image_limit.present?
        render json: { data: @image_limit }
      else
        render json:{ message: "book Image limit Not Found.", status: 404 }, status: :not_found
      end
    end

    def get_additional_price_per_page
      @get_additional_price_per_page = BxBlockBook::AdditionalPricePerPage.first.additional_price
      if @get_additional_price_per_page.present?
        render json: { price_per_page: @get_additional_price_per_page }
      else
        render json:{ message: "additional price per page Not Found.", status: 404 }, status: :not_found
      end
    end

    def get_delivery_charge
      @delivery_charges = BxBlockBook::DeliveryCharge.all
      if @delivery_charges.present?
        render json: BxBlockBook::DeliveryChargeSerializer.new(@delivery_charges).serializable_hash, status: :ok
      else
        render json:{ message: "delivery charges not found.", status: 404 }, status: :not_found
      end
    end

    def get_book_price
      if (params[:cover_type] == 'hard cover' || params[:cover_type] == 'soft cover')
        @price = BxBlockBook::Price.find_by(cover_type: params[:cover_type])
        find_min_limit = BxBlockBook::Price.find_by(cover_type: params[:cover_type]).min_limit
        find_additional_price_per_page = BxBlockBook::AdditionalPricePerPage.first.additional_price
      
        if params[:no_of_pages].to_i > find_min_limit
          additional_pages = params[:no_of_pages].to_i - find_min_limit
          total = additional_pages.to_i * find_additional_price_per_page
          total_price = total + @price.price
          render json: { total_price: total_price, price: @price }
        else
          render json: { price: @price }
        end
      else
        render json: { message: "this cover type not present", status: 404 }, status: :not_found
      end
    end

    def add_a_different_photo
      @book.images.attach(data: params[:image])
      return success_response(@book, :created)
    end
    
    def shuffle_photos
      @book = BxBlockBook::Book.find_by(id: params[:bookId])
      attachment = ActiveStorage::Attachment.find_by(id: params["source"][:sourceId])
      attachment.update(index: params["source"][:sourceIndex])
      attachment1 = ActiveStorage::Attachment.find_by(id: params["destination"][:destinationId])
      attachment1.update(index: params["destination"][:destinationIndex])
      return success_response(@book)
    end

    def crop_photo
      @book = BxBlockBook::Book.find_by(id: params[:bookId])
      attachment = ActiveStorage::Attachment.find_by(id: params[:imageId])
      attachment&.delete
      if params[:images].present?
        if params[:type] == 'book_image'
          params[:images].each do |image|
            @book.images.attach(data: image)
          end
          @book.images.last.update(index: params[:index], width: params[:width], height: params[:height], is_cover: params[:is_cover], image_caption: params[:image_caption], image_type: params[:image_type])
        elsif params[:type] == 'book_cover'
          params[:images].each do |image|
            @book.cover_image.attach(data: image)
          end
          @book.cover_image.update(index: params[:index], width: params[:width], height: params[:height], is_cover: params[:is_cover], image_caption: params[:image_caption], image_type: params[:image_type])
        end
      end
      
      return success_response(@book)  
    end

    def get_user_link
      @id = validate_json_web_token
      @account = AccountBlock::Account.find_by(id: @id.id)
      if @account.present?
        contribution = BxBlockBook::Contribution.create(user_id: @account.id, unique_identify_id: get_unique_identify_id, shared_link: @account.shared_link, name: params[:name], email: params[:email])
        render json: { shared_link: @account.shared_link, unique_identify_id: contribution.unique_identify_id, status: 200 }, status: :ok
      else
        render json: { message: MESSAGE, status: 404 }, status: :not_found
      end
    end

    def add_user_details
      @contribute = BxBlockBook::Contribution.create(name: params[:name], email: params[:email])
      render json: { email: @contribute.email, name: @contribute.name, status: 200 }, status: :ok
    end

    def get_contributed_images
      @id = validate_json_web_token
      @account = AccountBlock::Account.find_by(id: @id.id)
      @contributed_images =  BxBlockBook::Contribution.where(shared_link: params[:shared_link])
      render json: {data: BxBlockBook::ContributionSerializer.new(@contributed_images)}
    end

    def start_contributing_images
      @id = validate_json_web_token
      @account = AccountBlock::Account.find_by(id: @id.id)
      if @account.present?
        @contribution = BxBlockBook::Contribution.find_by(shared_link: params[:shared_link])
        @contribution.friend_id = @account.id
        @contribution.save
        if params[:images].present?
          params[:images].each do |image|
            @contribution.images.attach(data: image)
          end
        end
        render json: BxBlockBook::ContributionSerializer.new(@contribution).serializable_hash, status: :ok
      else
        render json: { message: MESSAGE, status: 404 }, status: :not_found
      end  
    end

    def delete_contributed_images
      @id = validate_json_web_token
      @account = AccountBlock::Account.find_by(id: @id.id)
      if @account.present?
        params[:image_ids].each do |image|
          ActiveStorage::Attachment.find_by(id: image)&.delete
        end
        render json: { message: "Attachment destroyed successfully" }, status: 200
      else
        render json: { message: MESSAGE, status: 404 }, status: :not_found
      end
    end

    def book_update_new
      @orders = BxBlockOrderManagement::Order.where(book_id: @book.id)
      if params[:images].present?
        images_added = (params[:images].last[:index] + 1) > @book.images.count
        params[:images].each do |image|
          @book.images.attach(image["signed_id"])
          @book.images.last.update(width: image["width"], height: image["height"], index: image["index"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], show_date: image["show_date"], image_caption: image["image_caption"], face_position: image["face_position"])
        end

        @orders.each do |order|
          family_member = order&.address&.share_with_family_member #boolean values 
          BxBlockOrderManagement::RemoveCoupon.new(order, {}).call if order.coupon_code_id && images_added
          order.update_additional_page_price(@book&.images&.count&.to_i, family_member)
        end
      end
      if params[:cover_image].present?
        params[:cover_image].each do |image|
          @book.cover_image.attach(image["signed_id"])
          @book.cover_image.update(width: image["width"], height: image["height"], dpi: image["dpi"], image_type: image["image_type"], image_date: image["image_date"], show_date: image["show_date"], image_caption: image["image_caption"])
        end
      end
      return success_response(@book)
    end

    private

    def find_book
      @book = Book.find_by(id: params[:id])
      render json: { message: "Invalid Book id" }, status: 422 and return unless @book.present?
    end

    def book_create_params
      params.permit(:month, :year, :spine_title, :cover_image, :from_year, :from_month, :to_year, :to_month)
    end

    def book_update_params
      params.permit(:book_title, :month_range, :month_year, :book_color, :title_layout, :spine_title, :title_color, :logo_color, :cover_type, :cover_image, :from_year, :from_month, :to_year, :to_month, :month, :year)
    end

    def error_response(book)
      render json: {
        errors: format_activerecord_errors(book.errors)
      },
      status: :unprocessable_entity
    end

    def find_existing_book
      begin
        @book = BxBlockBook::Book.find_by(month: params[:month], year: params[:year])
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors: [
          { book: 'Book Not Found' },
        ]}, status: 404
      end
    end

    def success_response(book, status = 200)
      render json: BxBlockBook::BookSerializer.new(book).
        serializable_hash,
        status: status
    end

    def check_order
      @order = BxBlockOrderManagement::Order.find_by(id: params[:id])
    end

    def get_unique_identify_id
      o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
      (0...5).map { o[rand(o.length)] }.join
    end

  end
end

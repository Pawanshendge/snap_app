ActiveAdmin.register BxBlockBook::Book, as: 'Books' do
  permit_params :year, :month, :flag, :account_id, :book_color, :title_layout, :cover_type, :paper_type, :book_title, :month_range, :month_year, :images, :cover_image

  remove_filter :images_attachments
  remove_filter :images_blobs
  remove_filter :cover_image_attachment
  remove_filter :cover_image_blob

  controller do
    def index
    #   index! do |format|
    #     format.html
    #     format.pdf {
    #       @book  = BxBlockBook::Book.all
    #       pdf_html = ActionController::Base.new.render_to_string(template: 'all_book',  locals: { books: @book})
    #       pdf = WickedPdf.new.pdf_from_string(pdf_html)
    #       send_data pdf, filename: 'book.pdf'   

    #     }
    #   end

      super
    end
  end
  
  action_item :download_image, only: :show do
    link_to 'Download images in zip', bulk_download_zip_bx_block_book_book_path(resource.id)
  end

  index do
    selectable_column
    id_column
    column :year
    column :month
    column :account_id
    column :book_color
    column :title_layout
    column :cover_type
    column :paper_type
    column :book_title
    column :month_range
    column :month_year
    # column :images
    column :shareable_identity
    actions default: false do |book|
      link_to 'Download Book', download_pdf_bx_block_book_book_path(book.id, format: :pdf),
      class: 'view_link member_link'
    end
  end

  show do |book|
    div do
      if book.book_title.present?
         h3 book.book_title
      else
        h3 book.year
        h3 book.month
      end

      div :class => "col-xs-4" do
        if book.cover_image.present?
          image_tag(url_for(book.cover_image),width:500,height:500)
        end
      end

      div :class => "col-xs-4" do
        if book.cover_image.present?
          @host = Rails.env.development? ? 'http://localhost:3000' : ENV['HOST_URL']
          link_to "Download this image", @host + rails_blob_path(book.cover_image, only_url: true).html_safe, disposition: 'attachment', download: true
        end
      end

      book&.images&.order(:index).each do |image|   
        td do
          div :class => "col-xs-4" do
            image_tag(url_for(image),width:500,height:500)
          end
        end
      end
    end
  end
end
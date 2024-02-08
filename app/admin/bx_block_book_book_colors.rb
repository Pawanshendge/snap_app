ActiveAdmin.register BxBlockBook::BookColor, as: "Book Colors" do
  permit_params :book_color, :title_color, :logo_color

  controller do
    def action_methods
      if BxBlockBook::BookColor.all&.count < 3
        super
      else
        super - ['new', 'create']
      end
    end

    def index
      index! do |format|
        format.html
        format.pdf {
          @book  = BxBlockBook::BookColor.all
          pdf_html = ActionController::Base.new.render_to_string(template: 'all_book_color',  locals: { books: @book})
          pdf = WickedPdf.new.pdf_from_string(pdf_html)
          send_data pdf, filename: 'book_color.pdf'  
        }
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      li do
        f.input :book_color, as: :color
        f.input :logo_color, as: :color
        f.input :title_color, as: :color
      end
    end

    f.actions
  end
  show do |rnr_policy|
      rnr_policy.book_color
      rnr_policy.title_color
      
  end

end
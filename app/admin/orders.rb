ActiveAdmin.register BxBlockOrderManagement::Order, as: "Orders" do
  permit_params :account_id, :sub_total, :amount, :no_of_pages, :book_size, :book_title, :book_color, :cover_type, :paper_type, :book_id, :placed_at
  actions :all, :except => [:edit, :new]
    
  controller do
    def index

      index! do |format|
        format.html
        format.pdf {
          @orders  = BxBlockOrderManagement::Order.all
          pdf_html = ActionController::Base.new.render_to_string(template: 'all_order',  locals: { orders: @orders})
          pdf = WickedPdf.new.pdf_from_string(pdf_html)
          send_data pdf, filename: 'file.pdf'   
        }
      end
    end
  end
  
  action_item :download_image, only: :show do
    link_to 'Download images in zip', bulk_download_zip_bx_block_book_book_path(resource.book_id, order_id: resource.id)
  end

  index do
    selectable_column
    id_column
    column :account_id 
    column :sub_total 
    column :amount 
    column :no_of_pages
    column :book_size
    column :book_title          
    column :book_color
    column :cover_type
    column :paper_type
    column :book_id
    column :status
    column :payment_status
    # column :placed_at
    column :placed_at, :sortable => :placed_at do |obj|
     obj.placed_at.localtime.in_time_zone("Asia/Kolkata") if obj.placed_at.present?
    end  
    column "Size" do |order|
      total = 0
      book = BxBlockBook::Book.find_by(id: order.book_id)
      if book&.images.present?
        book&.images.each do |image|
          total += image.blob.byte_size
        end
      end
      total
    end
    column "email" do |order|
      order.account&.email
    end
    column "full_phone_number" do |order|
      order.account&.full_phone_number
    end
    actions default: false do |order|          
      link_to 'Download Order', download_order_bx_block_book_book_path(order.id, format: :pdf),
      class: 'view_link member_link'
    end
  end

  show do
    attributes_table do
      row "Order Id" do |order|
        order&.id
      end
      row :order_number
      row "Order Date" do |order|
        # order&.created_at
        order&.created_at.localtime.in_time_zone("Asia/Kolkata")
      end
      row :account_id
      row :status
      row :applied_discount
      row :sub_total
      row :amount
      row :razorpay_order_id
      row :ship_rocket_order_id
      row :ship_rocket_status
      row :ship_rocket_shipment_id

      panel "Book Details" do
        @book = BxBlockBook::Book.find_by(id: resource.book_id)
        table_for @book do
          column :id
          column "book_size" do |book|
            resource&.book_size
          end
          column "book_title" do |book|
            book&.book_title
          end
          column "book_color" do |book|
            book&.book_color
          end
          column "cover_type" do |book|
            book&.cover_type
          end
          column "no_of_pages" do |book|
            resource&.no_of_pages
          end
          column "book_url" do |book|
            link_to resource&.book_url, resource&.book_url, target: :_blank
          end
        end
      end

      panel "Customer Details" do
        table_for resource.address do
            column :id
            column "full_name" do |q|
              q&.full_name
            end
            column "pincode" do |q|
              q&.pincode
            end
            column "city" do |q|
              q&.city
            end
            column "address" do |q|
              q&.address
            end
            column "state" do |q|
              q&.state
            end
            column "email" do |q|
              q&.email_address || resource.account&.email
            end
            column "phone_number" do |q|
              q&.phone_number || resource.account&.full_phone_number
            end
          end
      end
    end
  end

  action_item :complete_order, only: :show do
    link_to 'Complete Order', complete_admin_order_path(resource), method: :put if resource.status != 'delivered'
  end

  member_action :complete, method: :put do
    resource.update(status: "delivered")
    redirect_to resource_path(resource), notice: "Order completed!"
  end
end




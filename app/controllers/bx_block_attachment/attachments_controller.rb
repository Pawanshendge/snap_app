module BxBlockAttachment
  class AttachmentsController < ApplicationController
    # include BuilderJsonWebToken::JsonWebTokenValidation
    # before_action :validate_json_web_token, :validate_blacklisted_user
    before_action :set_account, only: [:get_user_attachments, :create]
    before_action :set_attachment, only: [:save_print_properties, :set_is_printed]

    def update_image
      attachment = ActiveStorage::Attachment.find_by(id: params[:id])
      if attachment.present?
        if attachment.update(attachment_update_params)
          # attachment.update(show_date: true)
          render json: { message: "image update successfully", status: 200 }, status: :ok
        else
          render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity        
        end
      else
        render json: { message: "photo not found with this id", status: 404 }, status: :not_found
      end
    end

    def delete_image
      attachment = ActiveStorage::Attachment.find_by(id: params[:id])
      deleted_index = attachment&.index
      @book = BxBlockBook::Book.find_by(id: params[:book_id])
      @orders = BxBlockOrderManagement::Order.where(book_id: @book.id)
      if attachment.delete
        attachments = @book&.images&.where('index > ?', deleted_index)
        # attachments = ActiveStorage::Attachment.where('index > ?', deleted_index)
        attachments.each do |attach|
          attach.update(index: attach.index-1)
        end
        @orders.each do |order|
          family_member = order&.address&.share_with_family_member #boolean values 
          BxBlockOrderManagement::RemoveCoupon.new(order, {}).call if order.coupon_code_id
          order.update_additional_page_price(@book&.images&.count&.to_i, family_member)
          # order.update_additional_page_price(@book&.images&.count&.to_i)
        end
        render json: { message: "Attachment destroyed successfully" }, status: 200
      else
        render json: { message: "something went wrong", status: 422 }, status: :unprocessable_entity 
      end
    end

    def get_user_attachments
      if @account.present?
        if @account.attachments.present?
          @attachments = Array.new
          @account.attachments.order('created_at DESC').each do |attachment|
            if attachment&.attachment&.attached? && attachment.orders&.blank?
              @attachments <<  attachment
            end
          end
          if @attachments.present?
            render json: AttachmentSerializer.new(@attachments).serializable_hash
          else
            return render json: {errors: [
              {account: 'No Attachments for this user'},
            ]}, status: :unprocessable_entity
          end
        else
          return render json: {errors: [
            {account: 'No Attachments for this user'},
          ]}, status: :unprocessable_entity
        end
      else
        return render json: {errors: [
          {account: 'User not found'},
        ]}, status: :unprocessable_entity
      end
    end

    def save_print_properties
      if @attachment.present?
        if params[:attachment_data][:set_all] == "1"
          if @attachment.account.attachments.present?
            # document_count = 0
            params[:attachment_data][:colour] = params[:attachment_data][:colour].capitalize
            params[:attachment_data][:page_size] = params[:attachment_data][:page_size].capitalize
            params[:attachment_data][:print_sides] = params[:attachment_data][:print_sides].capitalize
            @attachment.account.attachments.each do |attachment|
              if attachment&.attachment&.attached?
                if attachment.update_attributes(attachments_params)
                  # document_count += 1
                else
                  render json: {errors: @attachment.errors},
                         status: :unprocessable_entity
                end
              end
            end
            if params[:attachment_data][:total_doc].present? and params[:attachment_data][:total_doc].to_i > 0
              document_count = params[:attachment_data][:total_doc]
              render json: AttachmentSerializer.new(@attachment.account.attachments, meta: {
                message: "All #{document_count} Documents Updated Successfully"
              }).serializable_hash, status: :ok
            end
          end
        else
          params[:attachment_data][:colour] = params[:attachment_data][:colour].capitalize
          params[:attachment_data][:page_size] = params[:attachment_data][:page_size].capitalize
          params[:attachment_data][:print_sides] = params[:attachment_data][:print_sides].capitalize
          if @attachment.update_attributes(attachments_params)
            render json: AttachmentSerializer.new(@attachment, meta: {
              message: "Document Updated Successfully"
            }).serializable_hash, status: :ok
          else
            render json: {errors: @attachment.errors},
                   status: :unprocessable_entity
          end
        end
      else
        return render json: {errors: [
          {account: 'Document not found'},
        ]}, status: :unprocessable_entity
      end
    end

    def set_is_printed
      if @attachment.update_attributes(is_printed: params[:data][:is_printed])
        render json: AttachmentSerializer.new(@attachment).serializable_hash
      else
        return render json: {errors: [
          {account: 'Something went wrong'},
        ]}
      end
    end

    private

    def attachment_update_params
      params.permit(:image_caption, :image_type, :cover_image, :show_date)
    end

    def set_attachment
      @attachment = BxBlockAttachment::Attachment.find(params[:id])
    end

    def set_account
      if params[:data].present?
        @account = AccountBlock::Account.find params[:data][:account_id]
      else
        @account = AccountBlock::Account.find params[:id]
      end
    end

    def attachments_params
      params.require(:attachment_data).permit(:colour, :layout, :page_size, :scale, :print_sides,
                                              :print_pages_from, :print_pages_to, :total_pages,
                                              :is_expired, :attachment)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end
  end
end

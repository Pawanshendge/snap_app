module BxBlockAddress
  class AddressesController < BxBlockAddress::ApplicationController
    before_action :get_account, only: [:index, :create, :update, :destroy, :address_create]
    before_action :check_order, only: [:create, :get_address, :update_address]

    def index
      @account_addresses = Address.where(addressble_id: @account.id)
      render json: {
        message: 'No Address is present'
      } and return unless @account_addresses.present?

      render json: BxBlockAddress::AddressSerializer.new(
        @account_addresses, meta: {message: 'List of all addresses'}
      ).serializable_hash
    end

    def create
        @address = @order.build_address(address_params.merge( { addressble_id: @account.id, order_id: params[:order_id] } ))
        if @address.save
          if (@address.share_with_family_member == true)
            check_address_shared_with_family_or_not
          end
          render json: BxBlockAddress::AddressSerializer.new(@address, meta: {
            message: 'Address Created Successfully',
          }).serializable_hash, status: :created
        else
          render json: { errors: format_activerecord_errors(@address.errors) },
                 status: :unprocessable_entity
        end
    end

    def address_create
      @address = Address.create(address_params.merge(addressble_id: @account.id))
      if @address.save
        render json: BxBlockAddress::AddressSerializer.new(@address, meta: {
          message: 'Address Created Successfully',
        }).serializable_hash, status: :created
      else
        render json: { message: "Address not created", status: 404 }, status: :not_found
      end
    end

    def update
      @address = Address.find_by(id: params[:id])
      if @address.update(address_params)
        render json: BxBlockAddress::AddressSerializer.new(@address, meta: {
          message: 'Address Updated Successfully',
        }).serializable_hash, status: :created
      else
        # render json: { errors: format_activerecord_errors(@address.errors) }, status: :unprocessable_entity
        render json: { message: "Something went wrong. Please try again", status: 404 }, status: :not_found
      end
    end

    def get_address
      if (@order.present? && @order.address.present?)
        render json: BxBlockAddress::AddressSerializer.new(@order.address, meta: {
          message: 'List of all addresses',
        }).serializable_hash
      else
        render json: { message: "address not present", status: 404 }, status: :not_found
      end
    end

    def update_address
      if (@order.present? && @order.address.present?)
        @order.address.update(address_params)
        if @order.address.saved_change_to_share_with_family_member?
          check_address_shared_with_family_or_not
        end
        render json: BxBlockAddress::AddressSerializer.new(@order.address, meta: {
          message: 'List of all addresses',
        }).serializable_hash
      else
        render json: { message: "Address not found, Please try again ", status: 404 }, status: :not_found
      end
    end

    def destroy
      @address = Address.find_by(id: params[:id])
      if @address.present?
        @account_addresses = Address.where(addressble_id: @account.id, pincode: @address.pincode, city: @address.city,address: @address.address)
        @account_addresses.update_all(is_deleted: true)
          if @address.destroy
           render json: { message: "address destroyed successfully" }, status: 200
           else
            render json: { message: "Address not destroy", status: 404 }, status: :not_found
          end
      else
        render json: { message: "Address not found", status: 404 }, status: :not_found
      end  
    end

    private

    def address_params
      params.permit(:email_address, :phone_number, :full_name, :pincode, :city, :address, :landmark, :state, :share_with_family_member, shared_address_attributes: [:phone_number, :full_name, :pincode, :city,  :landmark, :state, :address1])
    end

    def get_account
      @account = AccountBlock::Account.find(@token.id)
    end
    def check_order
      @order = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
    end

    def check_address_shared_with_family_or_not
      @order_details = BxBlockOrderManagement::Order.find_by(id: params[:order_id])
      if (@order_details&.address&.share_with_family_member == true)
        @order_details.update(quantity: 2)
        @order_details.amount = (@order_details.amount * 2)
        @order_details.sub_total = (@order_details.sub_total * 2)
        @order_details.tax_charges = (@order_details.tax_charges.to_f * 2)
        @order_details.delivery_charges = (@order_details.delivery_charges.to_i * 2)
        @order_details.additional_pages = (@order_details.additional_pages.to_i * 2)
        @order_details.additional_price = (@order_details.additional_price.to_i * 2)
        @order_details.total = (@order_details.total.to_f * 2)
        @order_details.base_price = (@order_details.base_price.to_i * 2)
        @order_details.save
      else
        @order_details.update(quantity: 1)
        @order_details.amount = (@order_details.amount / 2)
        @order_details.sub_total = (@order_details.sub_total / 2)
        @order_details.tax_charges = (@order_details.tax_charges.to_f / 2)
        @order_details.delivery_charges = (@order_details.delivery_charges.to_i / 2)
        @order_details.additional_pages = (@order_details.additional_pages.to_i / 2)
        @order_details.additional_price = (@order_details.additional_price.to_i / 2)
        @order_details.total = (@order_details.total.to_f / 2)
        @order_details.base_price = (@order_details.base_price.to_i / 2)
        @order_details.save
      end

      @coupon =  BxBlockDiscountsoffers::Offer.find_by(id: @order_details.coupon_code_id)
      if @order_details.coupon_code_id.present? && @coupon
        family_member = @order_details&.address&.share_with_family_member #boolean values 
        BxBlockOrderManagement::RemoveCoupon.new(@order_details, {}).call if @order_details.coupon_code_id
        @order_details.update_additional_page_price(@book&.images&.count&.to_i, family_member)
      end
    end
  end
end
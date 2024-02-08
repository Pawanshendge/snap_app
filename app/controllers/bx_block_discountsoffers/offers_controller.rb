module BxBlockDiscountsoffers
  class OffersController < BxBlockDiscountsoffers::ApplicationController

    def index
      old_user = @current_user.orders.where(status: "placed").any?
      if old_user
        valid_for = ['old_users', 'all_users']
      else
        valid_for =['new_users', 'all_users']
      end
      @offers = []
      @offers += BxBlockDiscountsoffers::Offer.where(coupon_type: ["normal", nil], active: true, valid_for: valid_for) 
      @offers += BxBlockDiscountsoffers::Offer.where(coupon_type: ["specfic_user", nil], active: true)

      if @offers.present?
        render json: BxBlockDiscountsoffers::OfferSerializer.new(@offers).serializable_hash, status: :ok        
      else
        render json:{ message: "Currently there are no offers.", status: 404 }, status: :not_found
      end
    end

    def create_admin
      AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
    end
  end
end

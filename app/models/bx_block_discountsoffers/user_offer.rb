module BxBlockDiscountsoffers
  class UserOffer < BxBlockDiscountsoffers::ApplicationRecord
    self.table_name = :user_offers

    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :offer, class_name: 'BxBlockDiscountsoffers::Offer'

    validates :code, presence: true

    enum coupon_type: [:normal, :referral, :share_order_code, :specfic_user]
  end
end


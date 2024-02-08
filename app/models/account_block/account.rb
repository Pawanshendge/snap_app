module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    self.table_name = :accounts
    self.primary_key = "id"

    include Wisper::Publisher

    # has_secure_password
    # before_validation :parse_full_phone_number
    # before_create :generate_api_key
    has_one :blacklist_user, class_name: 'AccountBlock::BlackListUser', dependent: :destroy
    has_many :books, class_name: 'BxBlockBook::Book'
    has_many :user_offers, class_name: 'BxBlockDiscountsoffers::UserOffer'
    has_many :orders, class_name: "BxBlockOrderManagement::Order"
    has_many :addresses, class_name: "BxBlockAddress::Address"
    has_many :order_transactions, class_name: "BxBlockOrderManagement::OrderTransaction", dependent: :delete_all
    # after_save :set_black_listed_user
    # after_save :activate_account
    after_create :attach_shareable_link_to_account
    has_one :referral_user, class_name: "BxBlockReferrals::ReferralUser"
    has_one_attached :profile_picture
    enum status: %i[regular suspended deleted]
    has_many :invite_user, class_name: "BxBlockBook::InviteUser", dependent: :destroy

    scope :active, -> { where(activated: true) }
    scope :existing_accounts, -> { where(status: ['regular', 'suspended']) }

    def full_name
     "#{first_name} #{last_name}"
    end

    private

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Invalid or Unrecognized Phone Number")
      end
    end

    def generate_api_key
      loop do
        @token = SecureRandom.base64.tr('+/=', 'Qrt')
        break @token unless Account.exists?(unique_auth_id: @token)
      end
      self.unique_auth_id = @token
    end

    def set_black_listed_user
      if is_blacklisted_previously_changed?
        if is_blacklisted
          AccountBlock::BlackListUser.create(account_id: id)
        else
          blacklist_user.destroy
        end
      end
    end

    def activate_account
      self.update_column(:activated, true) unless self.activated
    end

    def attach_shareable_link_to_account
      o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
      shared_code = (0...10).map { o[rand(o.length)] }.join

      self.shared_link = check_enviroment + shared_code
      self.save
    end

    def check_enviroment
      if Rails.env.development?
        'http://localhost:3000/'
      else
        "https://snapslikeapp2-89023-react-native.b89023.dev.eastus.az.svc.builder.cafe/"
      end
    end
  end
end

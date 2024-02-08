module BxBlockAddress
  class Address < BxBlockAddress::ApplicationRecord
    self.table_name = :addresses

    belongs_to :account, class_name: 'AccountBlock::Account',
                         foreign_key: 'addressble_id'

    belongs_to :order, class_name: 'BxBlockOrderManagement::Order',
                         foreign_key: 'order_id'
    # reverse_geocoded_by :latitude, :longitude
    validates :email_address, :phone_number, :full_name, :pincode, :city, :address, :state, presence: true
    has_one :shared_address, class_name: 'BxBlockAddress::SharedAddress', dependent: :destroy
    accepts_nested_attributes_for :shared_address, allow_destroy: true
    scope :active, -> { where(is_deleted: false) }

    # enum address_type: { 'Home' => 0, 'Work' => 1, 'Other' => 2 }
    # after_validation :reverse_geocode
    # before_create :add_address_type

    # private
    # def add_address_type
    #   self.address_type = 'Home' unless self.address_type.present?
    # end
  end
end

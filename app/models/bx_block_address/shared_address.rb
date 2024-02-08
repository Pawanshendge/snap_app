module BxBlockAddress
  class SharedAddress < ApplicationRecord
    self.table_name = :shared_addresses

    belongs_to :address, class_name: 'BxBlockAddress::Address', foreign_key: 'addressble_id'
  end
end

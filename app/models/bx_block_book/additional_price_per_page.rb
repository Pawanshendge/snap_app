module BxBlockBook
  class AdditionalPricePerPage < BxBlockBook::ApplicationRecord
    self.table_name = :additional_price_per_pages

    validates :additional_price, presence: true
    
    before_destroy do
      unless self.class.count > 1
        errors.add :base, "atleast one per page price record should be present"
        false
        throw(:abort)
      end
    end
  end
end

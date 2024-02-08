module BxBlockBook
  class DeliveryCharge < BxBlockBook::ApplicationRecord
    self.table_name = :delivery_charges
    validates :charge, presence: true, uniqueness: true

    before_destroy do
      unless self.class.count > 1
        errors.add :base, "atleast one delivery charge record should be present"
        false
        throw(:abort)
      end
    end
  end
end

module BxBlockBook
  class Price < BxBlockBook::ApplicationRecord
    self.table_name = :prices

    validates :cover_type, presence: true, inclusion: { in: ['soft cover', 'hard cover'], message: "cover type only hard cover and soft cover accepted" }
    validates :price, presence: true
    validates :book_size, presence: true
    validates :min_limit, presence: true
    validates :max_limit, presence: true
    validate :valid_min_limit_max_limit
   
    before_destroy do
      unless self.class.count > 1
        errors.add :base, "atleast one price record should be present"
        false
        throw(:abort)
      end
    end

    private

    def valid_min_limit_max_limit
      if (min_limit > max_limit)
        errors.add(:max_limit, "must be greate than min limit")
        false
        throw(:abort)
      end
    end
  end
end

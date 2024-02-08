module BxBlockBook
  class BookColor < ApplicationRecord
    self.table_name = :book_colors

    validates :book_color, presence: true
    validates :title_color, presence: true
    validates :logo_color, presence: true

    before_destroy do
      unless self.class.count > 1
        errors.add :base, "atleast one color record should be present"
        false
        throw(:abort)
      end
    end
  end
end

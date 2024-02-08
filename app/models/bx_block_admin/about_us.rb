module BxBlockAdmin
  class AboutUs < BxBlockAdmin::ApplicationRecord
    self.table_name = :about_us
    self.primary_key = "id"
    
    validates :description, presence: true
  end
end

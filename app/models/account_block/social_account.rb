module AccountBlock
  class SocialAccount < Account
    include Wisper::Publisher

    validates :email, uniqueness: true, presence: true
    # validates :unique_auth_id, presence: true
    after_validation :set_active

    def set_active
      self.activated = true
    end

    def self.create_from_omniauth(auth)
      # Creates a new user only if it doesn't exist
      where(email: auth.info.email).first_or_initialize do |user|
        user.unique_auth_id = auth.uid
        user.full_name = auth.info.name
        user.email = auth.info.email
        user.save
      end
    end
  end
end

module OmniauthMacros
  def self.google_provider_info
    OmniAuth.config.mock_auth[:google_oauth2] = { "provider" => "google_oauth2",
      "uid" => "100000000000000000000",
      "info" => {
        "name" => "John Smith",
        "email" => "john@example.com",
        "first_name" => "John",
        "last_name" => "Smith",
        "image" => "https://lh4.googleusercontent.com/photo.jpg",
        "urls" => {
          "google" => "https://plus.google.com/+JohnSmith"
        }
      } 
    }
  end
end

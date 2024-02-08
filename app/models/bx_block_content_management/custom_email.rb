module BxBlockContentManagement
  class CustomEmail < ApplicationRecord
    self.table_name = :custom_emails

    enum email_type: %i[welcome_email activation_email draft_email order_placed_info]
    enum valid_for: %i[new_users old_users all_users]
    has_one_attached :image1
    has_one_attached :image2
    has_one_attached :image3
    has_one_attached :image4
    has_one_attached :image5
    has_one_attached :image6
    has_one_attached :image7
    has_one_attached :image8
  end
end

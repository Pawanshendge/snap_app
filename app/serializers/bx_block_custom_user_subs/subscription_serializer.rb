module BxBlockCustomUserSubs
  class SubscriptionSerializer < BuilderBase::BaseSerializer
    attributes *[
        :id,
        :name, 
        :details, 
        :book_original_price, 
        :no_of_books, 
        :gift_included, 
        :valid_up_to, 
        :total_amount, 
        :subscription_package_amount,
        :active
    ]

    attribute :expired do |object|
      object.valid_up_to < Date.today
    end

    attribute :image_link do |object|
      object.image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(object.image,only_path: true) : nil
    end

    attribute :subscribed do |object, params|
      account = object.user_subscriptions.pluck(:account_id).uniq
      account.include? params[:user].id  
    end

  end
end

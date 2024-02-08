ActiveAdmin.register BxBlockCustomUserSubs::Subscription, as: 'subscription' do
  require 'streamio-ffmpeg'

  permit_params :name, :details, :active, :book_original_price, :no_of_books, :gift_included, :valid_up_to, :total_amount, :subscription_package_amount

  index do
    selectable_column
    id_column
    column :name
    column :details
    column :book_original_price    
    column :no_of_books    
    column :gift_included    
    column :valid_up_to
    column :total_amount
    column :subscription_package_amount
    column :active    
    actions
  end
end

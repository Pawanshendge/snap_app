ActiveAdmin.register BxBlockBook::InviteUser do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :status, :sharable_link, :unique_identify_id, :account_id, :tale_books_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :status, :sharable_link, :unique_identify_id, :account_id, :table_books_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

ActiveAdmin.register BxBlockBook::ImageLimit do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :min_images, :max_images, :img_resolution
  #
  # or
  #
  # permit_params do
  #   permitted = [:min_images, :max_images, :img_resolution]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

ActiveAdmin.register BxBlockDiscountsoffers::UserOffer, as: "User Offers" do
  permit_params :account_id, :offer_id, :use_count, :code, :applied, :coupon_type

  index do
    selectable_column
    id_column
    column :account do |resource|
      resource.account_id if resource.account_id.present?
      # link_to("#{resource.account&.full_name}", admin_user_path(resource.account)) if resource.account
    end
    column :offer
    column :code
    column :applied
    column :use_count
    column :created_at
    column :updated_at
    column :coupon_type
    actions
  end
end

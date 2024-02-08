ActiveAdmin.register BxBlockOrderManagement::OrderTransaction, as: "Transactions" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :account_id, :order_id, :charge_id, :amount, :currency, :charge_status, :razorpay_order_id, :razorpay_payment_id, :razorpay_signature, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:account_id, :order_id, :charge_id, :amount, :currency, :charge_status, :razorpay_order_id, :razorpay_payment_id, :razorpay_signature, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    id_column
    column :account_id 
    column :order_id 
    column :amount
    column :razorpay_order_id
    column :razorpay_payment_id
    column :razorpay_signature
    column :status
    actions
  end
end

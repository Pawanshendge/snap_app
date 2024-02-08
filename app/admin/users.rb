ActiveAdmin.register AccountBlock::Account, as: "Users" do
  permit_params :first_name, :last_name, :full_phone_number, :email, :activated

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    column :activated
    actions
  end

  show do
    attributes_table do
      row :full_name
      row :provider
      row :google_token
      row :accounts
      row :shared_link
      row :email
      row :activated
      row :unique_auth_id
      row :email_verified
      row :phone_verified
      row :full_phone_number
      row :created_at
      row :updated_at
      row :type
    end
  end

  form do |f|
    f.inputs do
      f.input :activated
      f.input :full_name
      f.input :email
      f.input :full_phone_number


    f.actions
    end
  end

  controller do 
    def destroy
      sms_otps = AccountBlock::SmsOtp.where(full_phone_number: resource.full_phone_number)
      email_otps = AccountBlock::EmailOtp.where(email: resource.email)
      email_otps.destroy_all
      sms_otps.destroy_all
      super
    end
  end
end

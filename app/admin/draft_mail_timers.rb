ActiveAdmin.register AccountBlock::DraftMailTimer, as: 'Draft Mail Timer' do
  permit_params :first_mail_in_minuts, :second_mail_in_days

  # actions :index, :show, :edit, :update
end

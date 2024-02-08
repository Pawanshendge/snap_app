ActiveAdmin.register BxBlockReferrals::ReferralLimitSetting, as: 'Referral Limit Setting' do
  permit_params :max_order_refers, :active
  # actions :all, :except => [:new]
    form do |f|
    f.input :max_order_refers
    f.input :active
    f.actions
  end

end

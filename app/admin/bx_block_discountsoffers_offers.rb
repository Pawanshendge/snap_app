ActiveAdmin.register BxBlockDiscountsoffers::Offer, as: "Offers" do
  permit_params :phone_number, :email, :full_phone_number, :title, :description, :code, :min_cart_value, :discount, :discount_type, :valid_from, :valid_to, :active, :max_limit, :valid_for, :coupon_type, :max_capping_limit

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :coupon_type, as: :select
      f.input :title
      
      div class: "referral1-div" do
      f.input :description
      end

      div class: "referral2-div" do
      f.input :valid_for, as: :select
      end

      div class: "referral3-div" do
        f.input :code
      end

      div class: "specfic_user-div" do
        f.input :phone_number, as: :tags, collection: (AccountBlock::Account.all.map {|entity| entity.full_phone_number})
        f.input :email, as: :tags, collection: (AccountBlock::Account.all.map {|entity| entity.email})
      end
      f.input :min_cart_value
      f.input :discount
      f.input :discount_type, as: :select, collection: ['flat', 'percentage']
      div class: "cap-div" do
        f.input :max_capping_limit
      end
      # f.input :valid_from, as: :date_picker, input_html: { value: (Date.today).to_s }
# f.input :valid_from, as: :date_picker, input_html: { value: Date.today }
# f.input :valid_from, as: :date_picker, input_html: { data: { min_date: 0 } }
# f.input :valid_from, as: :date_picker, input_html: { data: { min_date: 0 } }
# f.input :valid_from, as: :date

# f.input :valid_from,   as: :date_time_picker, datepicker_options: { min_date: "2013-10-8"}
f.input :valid_from, as: :date_picker, input_html: { value: Date.today, min: Date.today }


      # f.input :valid_from, as: :date_picker#, hint: 'Please add time in GMT/UTC'
      f.input :valid_to, as: :date_picker#, hint: 'Please add time in GMT/UTC'
      f.input :active
      f.input :max_limit
      f.input :combine_with_other_offer
      div class: "discount-div" do
       f.input :extra_discount
       f.input :discount_type, as: :select, collection: ['flat', 'percentage']
      end
    end
    f.actions
  end
end
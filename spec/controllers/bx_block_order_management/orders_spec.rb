require 'rails_helper'
RSpec.describe "BxBlockOrderManagement::Order", type: :request do

  before(:each) do |example|
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")
    @account2 = FactoryBot.create(:account, email: "pawan@gmail.com")
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @verify_otp_params = { token: @login_token, format: :json }
    @order = FactoryBot.create(:order, account_id: @account.id)
    @price = FactoryBot.create(:price)
    @delivery_charges = FactoryBot.create(:delivery)
    @additional_price = FactoryBot.create(:additional_price)
    @book = FactoryBot.create(:book)
    @offers = FactoryBot.create(:offers)
    @order_2 = FactoryBot.create(:order, account_id: @account.id,coupon_code_id: @offers.id, book_id: @book.id)
    @path = "/bx_block_order_management/orders/orders_list"
    @path2 = "/bx_block_order_management/orders/remove_coupon"
    @update_path = "/bx_block_order_management/orders/#{@order.id}/update_order"
    @apply_coupon_path = '/bx_block_order_management/orders/apply_coupon'
    @ref = FactoryBot.create(:referral_user, account_id: @account.id)
 end

    it "get_order_detail" do
      get "/bx_block_order_management/orders/#{@order.id}/order_details",  headers: @verify_otp_params
      data = JSON.parse(response.body)
      puts data
    end  

    it "create_order" do
      post "/bx_block_order_management/orders/create_order", params: {:cover_type => "soft cover", :book_size => "8*8", :no_of_pages => 8}, headers: @verify_otp_params
      data = JSON.parse(response.body)
      puts data
    end

    it "create_order with additional pages" do
      post "/bx_block_order_management/orders/create_order", params: {:cover_type => "soft cover", :book_size => "8*8", :no_of_pages => 38}, headers: @verify_otp_params
      data = JSON.parse(response.body)
      puts data
    end

    context 'this is update order case' do
      it "update_order" do
        put @update_path, params: {:no_of_pages => 38}, headers: @verify_otp_params
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end
      it "update order book data" do
        put @update_path, params: {book_id:  @book.id}, headers: @verify_otp_params
        data = JSON.parse(response.body)  
        expect(response).to have_http_status(200)
      end
    end

    context 'this is get order list case' do
      it "order list" do
        get '/bx_block_order_management/orders/orders_list?order_type=draft', headers: @verify_otp_params
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end   

      it "fail order list " do
        get @path, headers: @verify_otp_params
        data = JSON.parse(response.body)
        expect(JSON.parse(response.body)).to eq({"message"=>"No order record found."})
      end
    end

    context 'this is coupon apply case ' do
      it "normal coupon code" do
       @normal = FactoryBot.create(:offers, coupon_type: "normal", code: "normalcode", email: @account.email)
        post @apply_coupon_path, headers: @verify_otp_params ,params: {discount: 20 ,order_id: @order.id ,code: @normal.code, max_limit: @offers.max_limit, coupon_type: @normal.coupon_type}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "normal coupon but discount_type: flat" do
       @normal_flat = FactoryBot.create(:offers, coupon_type: "normal", code: "normalcode", email: @account.email, discount_type: "flat")
        post @apply_coupon_path, headers: @verify_otp_params ,params: {discount: 20 ,order_id: @order.id ,code: @normal_flat.code, max_limit: @offers.max_limit, coupon_type: @normal_flat.coupon_type}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "specfic_user coupon" do
       @specfic_user = FactoryBot.create(:offers, coupon_type: "specfic_user", code: "offerscode", email: @account.email, active: true)
        post @apply_coupon_path, headers: @verify_otp_params ,params: {discount: 20 ,order_id: @order.id ,code: @specfic_user.code, max_limit: @offers.max_limit, coupon_type: @specfic_user.coupon_type}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "sharable_code coupon" do
       @sharable_code = FactoryBot.create(:offers, coupon_type: "share_order_code", code: "offers_code")
        post @apply_coupon_path, headers: @verify_otp_params ,params: {discount: 20 ,order_id: @order.id ,code: @sharable_code.code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "referral_code coupon" do
        @referral1 = @ref
        @referral = FactoryBot.create(:referral_user, account_id: @account2.id)
        @referral_code = FactoryBot.create(:referral_user, account_id: @account.id, referral_by: @referral1.referral_code)
        post @apply_coupon_path, headers: @verify_otp_params ,params: {discount: 20 ,order_id: @order.id ,code: @account.referral_user.referral_code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(422)
      end
    end

    context 'this is coupon remove case' do
      it "remove coupon" do
        patch @path2, headers: @verify_otp_params,params: {quantity: 1,amount: 1000,order_id: @order_2.id}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "remove coupon share_order_code" do
        @offers.update(code:@order_2.sharable_code, coupon_type: "share_order_code")
        @order_2.update(used_discount_code: @offers.code)
        @referral1 = @ref
        @referred_by_user = FactoryBot.create(:referral_user, account_id: @account.id, referral_by: @referral1.referral_code, referral_code: @offers.code)
        @user_offers = FactoryBot.create(:user_offers, account_id: @account.id,  offer_id: @offers.id, use_count:5, coupon_type: @offers.coupon_type, code: @offers.code )
        patch @path2, headers: @verify_otp_params, params: {order_id: @order_2.id, code: @offers.code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "remove coupon specfic_user" do
        @offers.update(code: "SPECIALUSER0", coupon_type: "specfic_user")
        @order_2.update(used_discount_code: @offers.code)
        @user_offers = FactoryBot.create(:user_offers, account_id: @account.id,  offer_id: @offers.id, use_count:5, coupon_type: @offers.coupon_type, code: @offers.code )
        patch @path2, headers: @verify_otp_params, params: {order_id: @order_2.id, code: @offers.code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "remove coupon normal" do
        @offers.update(code: "normal", coupon_type: "normal")
        patch @path2, headers: @verify_otp_params,params: {order_id: @order_2.id, code: @offers.code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end

      it "remove referral code" do
        @offers.update(code: "referral", coupon_type: "referral")
        patch @path2, headers: @verify_otp_params,params: {order_id: @order_2.id, code: @offers.code}
        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
      end
      
      it "fail this already remove_coupon " do
        @order_2.update(coupon_code_id: nil)
        patch @path2, headers: @verify_otp_params, params: {account_id: @order_2.account.id, order_id: @order_2.id}
        data = JSON.parse(response.body)
        expect(JSON.parse(response.body)).to eq({"message"=>"already removed coupon", "status"=>422})
      end

      it "coupon_id is not present" do
        patch @path2, headers: @verify_otp_params
        data = JSON.parse(response.body)
        expect(response).to have_http_status(422)
      end
    end

    it "draft_order_delete" do
      delete "/bx_block_order_management/orders/draft_order_delete/#{@order_2.id}", headers: @verify_otp_params, params: {order_id: @order_2.id, order_type: "draft"}
      data = JSON.parse(response.body)
      expect(JSON.parse(response.body)).to eq({ "data" => { "order" => " Deleted Successfully" } })
    end

    # it "download_order_pdf" do
    #   get "/bx_block_book/books/#{@order_2.id}/download_order" , params: { format: :pdf }
    #   expect(response.status).to eq 200
    #   puts "Successfully download pdf"
    # end    
end

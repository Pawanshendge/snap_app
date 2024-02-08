require 'rails_helper'
RSpec.describe "BxBlockOrderManagement::Order", type: :request do

   before(:each) do |example|
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @verify_otp_params = { token: @login_token, format: :json }
    @order = FactoryBot.create(:order, account_id: @account.id)
    @price = FactoryBot.create(:price)
    @delivery_charges = FactoryBot.create(:delivery)
    @additional_price = FactoryBot.create(:additional_price)
    @offers = FactoryBot.create(:offers)
    @order_2 = FactoryBot.create(:order, account_id: @account.id, coupon_code_id: @offers.id)
 end 

    it "order_summary create Sucessfully" do
      post "/bx_block_ordersummary/order_summary", params: {:quantity => "2", :gift_note => "My Oder Summary", :book_id => "1", :order_id => @order.id}
      data = JSON.parse(response.body)
      puts data
    end    

  context 'order x2' do
    it 'order x2 Sucessfully' do
      patch '/bx_block_ordersummary/order_summary/order_x2', params: { :order_id => @order.id }
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end    
    it 'order x2 Sucessfully' do
      patch '/bx_block_ordersummary/order_summary/order_x2', params: { :order_id => "" }
      expect(JSON.parse(response.body)).to eq({"message"=>"order not present", "status"=>422})
      puts JSON.parse(response.body)
    end    
  end 

  context 'Get order details' do
    it 'Get order detail Sucessfully' do
      get '/bx_block_ordersummary/order_summary/get_order_details', params: { :order_id => @order.id }
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end     
    it 'Get order detail Unsucessfully' do
      get '/bx_block_ordersummary/order_summary/get_order_details', params: { :order_id => "" }
      expect(JSON.parse(response.body)).to eq({"message"=>"something went wrong", "status"=>422})
      puts JSON.parse(response.body)
    end  
  end  

  context 'Update Gift Note' do
    it 'update gift note Sucessfully' do
      put '/bx_block_ordersummary/order_summary/add_gift_note', params: { :gift_note => "My Gift Note" , :order_id => @order.id }
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end     
    it 'update gift note Unsucessfully' do
      put '/bx_block_ordersummary/order_summary/add_gift_note', params: { }
      expect(JSON.parse(response.body)).to eq({"message"=>"something went wrong", "status"=>422})
      puts JSON.parse(response.body)
    end  
  end  

  context 'Get Book Url details' do
    it 'Get book url detail Sucessfully' do
      get '/bx_block_ordersummary/order_summary/get_book_url_details', params: { :order_id => @order.id }
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end     
    it 'Get book url detail Unsucessfully' do
      get '/bx_block_ordersummary/order_summary/get_book_url_details', params: { }
      expect(JSON.parse(response.body)).to eq({"message"=>"Please Enter Vaild Order Id"})
      puts JSON.parse(response.body)
    end  
  end  

  context 'Update order quantity' do
    it 'Update order quantity Sucessfully' do
      put '/bx_block_ordersummary/order_summary/update_quantity', params: { :order_id => @order.id , :quantity => 2}
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end     
    it 'Update order quantity Sucessfully' do
      put '/bx_block_ordersummary/order_summary/update_quantity', params: { :order_id => @order_2.id , :quantity => 2}
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end      
  end

end
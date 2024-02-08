require 'rails_helper'
RSpec.describe "BxBlockBook::Books", type: :request do
  before(:each) do |example|
    @book = FactoryBot.create(:book)
    @book_2 = FactoryBot.create(:book)
    @account = FactoryBot.create(:account, email: "deepali@gmail.com")
    @login_token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @verify_otp_params = { token: @login_token, format: :json }
    @price = FactoryBot.create(:price)
    @book_color = FactoryBot.create(:book_color)
    @get_image_limit = FactoryBot.create(:get_image_limit)
    @delivery_charges = FactoryBot.create(:delivery)
    @additional_price = FactoryBot.create(:additional_price)
    @order = FactoryBot.create(:order, account_id: @account.id, book_id: @book_2.id)
  end
    it "get_book_detail" do
      get "/bx_block_book/books/#{@book.id}"
      data = JSON.parse(response.body)
      puts data
    end
    it "create_book" do
      post "/bx_block_book/books" , params: { :month => "09 March" , :year => "2022"}
      expect(response).to have_http_status(:created)
      puts JSON.parse(response.body)
    end
    it "Update_book" do
      put "/bx_block_book/books/#{@book.id}" , params: { :book_title => "my special book" , :book_color => "Red"}
       expect(response).to have_http_status(201)
      puts JSON.parse(response.body)
    end
    it "Delete_book" do
      delete "/bx_block_book/books/#{@book.id}"
      expect(response).to have_http_status(200)
      puts JSON.parse(response.body)
    end
    # it "download_book_pdf" do
    #   get "/bx_block_book/books/#{@book.id}/download_pdf" , params: { format: :pdf }
    #   expect(response.status).to eq 200
    #   puts "Successfully download pdf"
    # end
  context 'bulk_download_zip' do
    it "bulk_download_zip without order" do
      get "/bx_block_book/books/#{@book.id}/bulk_download_zip" , params: { format: :pdf }
      expect(response.status).to eq 200
      puts "Successfully download pdf bulk_download_zip without order"
    end
    it "bulk_download_zip with order" do
      get "/bx_block_book/books/#{@book_2.id}/bulk_download_zip" , params: { format: :pdf }
      expect(response.status).to eq 200
      puts "Successfully download PDF bulk_download_zip with order"
    end
  end
    it "upload_image_through_url" do
      post "/bx_block_book/books/upload_image_through_url" , params: { :month => "09 March", :year => "2022"}
      expect(response.status).to eq 201
      puts JSON.parse(response.body)
    end
    it "book_create" do
      post "/bx_block_book/books/book_create" , params: { :month => "09 March", :year => "2022"}
      expect(response.status).to eq 201
      puts JSON.parse(response.body)
    end
    it "book_create_new" do
      post "/bx_block_book/books/book_create_new" , params: { :month => "09 March", :year => "2022"}
      expect(response.status).to eq 201
      puts JSON.parse(response.body)
    end
    it "replace_images" do
      patch "/bx_block_book/books/#{@book.id}/replace_images"
      expect(response.status).to eq 200
      puts JSON.parse(response.body)
    end
    it "book_color" do
      get "/bx_block_book/books/book_color"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      puts data
    end
    it "get_book_size_price" do
      get "/bx_block_book/books/get_book_size_price"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      puts data
    end
    it "get_image_limit" do
      get "/bx_block_book/books/get_image_limit"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      puts data
    end
    it "get_delivery_charge" do
      get "/bx_block_book/books/get_delivery_charge"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      puts data
    end
    it "get_additional_price_per_page" do
      get "/bx_block_book/books/get_additional_price_per_page"
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      puts data
    end
end
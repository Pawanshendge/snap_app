FactoryBot.define do
  factory :book, class: "BxBlockBook::Book" do
    year {}
    month {}
    # book_color {}
    # title_layout {}                                   # If on_sale is true, then sale_price should be present and should be <= price.
    # account_id {}
    # book_color{}
    # title_layout{}
    # cover_type{}
    # paper_type{}
    # book_title{}
    # month_range{}
    # month_year{}
    # images{}
    # shareable_identity{}
    # title_color{}
    # logo_color{}
    # spine_title{}
    # to_month{}
    # to_year{}
    # from_month{}
    # from_year{}
    # book_status{}
    #  after(:build) do |book|
    #   book.attachment_changes .new(
    #     images: Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/df-1.png'), 'image/png')
    #   )
    # end
    images{}
    cover_image{}
  end
  factory :book_color, class: "BxBlockBook::BookColor" do
    book_color { "pink" }
    logo_color {'logo_color'}
    title_color {'title_color'}
  end
  factory :get_image_limit, class: "BxBlockBook::ImageLimit" do
    min_images { '10' }
    max_images { '30' }
    img_resolution { '300' }
  end
end
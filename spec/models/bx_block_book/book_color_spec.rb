require 'rails_helper'

RSpec.describe BxBlockBook::BookColor, type: :model do
  context "validations test" do
    it "ensure presence of some attributes" do
      book_color = BxBlockBook::BookColor.create()
      expect(book_color.errors.messages[:book_color]).to eq(["can't be blank"])
    end
    it "ensure presence of some attributes" do
      title_color = BxBlockBook::BookColor.create()
      expect(title_color.errors.messages[:title_color]).to eq(["can't be blank"])
    end
    it "ensure presence of some attributes" do
      logo_color = BxBlockBook::BookColor.create()
      expect(logo_color.errors.messages[:logo_color]).to eq(["can't be blank"])
    end    
  end
end

require 'rails_helper'

RSpec.describe BxBlockBook::Book, type: :model do
  context "association test" do
    it "should belongs_to account " do
      t = BxBlockBook::Book.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockBook::Book.reflect_on_attachment(:images)
      expect(t.macro).to eq(:has_many_attached)
    end     
    it "should belongs_to account " do
      t = BxBlockBook::Book.reflect_on_attachment(:cover_image)
      expect(t.macro).to eq(:has_one_attached)
    end 

  end
end
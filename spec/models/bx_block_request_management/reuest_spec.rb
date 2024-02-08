require 'rails_helper'

RSpec.describe BxBlockRequestManagement::Request, type: :model do
  context "association test" do
    it "should belongs_to sender " do
      t = BxBlockRequestManagement::Request.reflect_on_association(:sender)
      expect(t.macro).to eq(:belongs_to)
    end     
    it "should belongs_to account " do
      t = BxBlockRequestManagement::Request.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end  
  end 
end 
require 'rails_helper'

RSpec.describe BxBlockContentManagement::Exam, type: :model do
  context "association test" do 
    it "ensure presence of some attributes" do
      from = BxBlockContentManagement::Exam.create()
      expect(from.errors.messages[:from]).to eq(["can't be blank"])
    end     
  end
end
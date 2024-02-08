require 'rails_helper'

RSpec.describe BxBlockContentManagement::Pdf, type: :model do
  context "validations test" do 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:pdf) }  
    end
    it "should belongs_to attached_item" do
      t = BxBlockContentManagement::Pdf.reflect_on_association(:attached_item)
      expect(t.macro).to eq(:belongs_to)
    end   
  end
end
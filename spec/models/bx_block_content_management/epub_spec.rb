require 'rails_helper'

RSpec.describe BxBlockContentManagement::Epub, type: :model do
  context "validation test" do

    it{ should accept_nested_attributes_for :pdfs } 
    
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:heading) }
      it { should validate_presence_of(:description) }  
    end        
  end
end
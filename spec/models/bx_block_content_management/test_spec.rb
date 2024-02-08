require 'rails_helper'

RSpec.describe BxBlockContentManagement::Test, type: :model do
  context "validations test" do 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:headline) }  
      it { should validate_presence_of(:description) }  
    end   
  end
end
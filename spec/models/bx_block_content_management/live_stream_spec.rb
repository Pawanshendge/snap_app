require 'rails_helper'

RSpec.describe BxBlockContentManagement::LiveStream, type: :model do
  context "validation test" do 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:headline) }  
    end
  end
end
require 'rails_helper'

RSpec.describe BxBlockContentManagement::ContentVideo, type: :model do
  context "validation test" do
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:headline) }
    end   
    it{ should accept_nested_attributes_for :video }   
    it{ should accept_nested_attributes_for :image }     
  end
end
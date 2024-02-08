require 'rails_helper'

RSpec.describe BxBlockLanguageOptions::ApplicationMessage, type: :model do
  context "validations test" do
    describe 'name should be presence' do
      it { should validate_presence_of(:name) }
     end
    it{ should accept_nested_attributes_for :translations }        
   end
end
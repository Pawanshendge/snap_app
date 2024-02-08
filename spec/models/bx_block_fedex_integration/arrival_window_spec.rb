require 'rails_helper'

RSpec.describe BxBlockFedexIntegration::ArrivalWindow, type: :model do
  context "association test" do
  	it "should belongs_to addressable " do
  		t = BxBlockFedexIntegration::ArrivalWindow.reflect_on_association(:addressable)
  		expect(t.macro).to eq(:belongs_to)
  	end	
    it { is_expected.to callback(:set_end_at).after(:initialize) }   
  end
end

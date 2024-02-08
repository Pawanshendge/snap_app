require 'rails_helper'

RSpec.describe AccountBlock::DashboardMediaFile, type: :model do
  context "association test" do
  	it "should has_one_attached media_file " do
  		t = AccountBlock::DashboardMediaFile.reflect_on_attachment(:media_file)
  		expect(t.macro).to eq(:has_one_attached)
  	end	
  end
end
require 'rails_helper'

RSpec.describe BxBlockBulkUploading::Attachment, type: :model do
  context "association test" do
  	it "should belongs_to account " do
  		t = BxBlockBulkUploading::Attachment.reflect_on_association(:account)
  		expect(t.macro).to eq(:belongs_to)
    end
    it "should has one attachment to attachment " do
      t = BxBlockBulkUploading::Attachment.reflect_on_attachment(:attachment)
      expect(t.macro).to eq(:has_one_attached)
    end	
  end
end

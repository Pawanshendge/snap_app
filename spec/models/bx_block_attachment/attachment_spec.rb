require 'rails_helper'

RSpec.describe BxBlockAttachment::Attachment, type: :model do
  context "association test" do
    it "should has_one_attached attachment " do
      t = BxBlockAttachment::Attachment.reflect_on_attachment(:attachment)
      expect(t.macro).to eq(:has_one_attached)
    end 
    it "should belongs_to account " do
      t = BxBlockAttachment::Attachment.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end
    it { is_expected.to callback(:default_values).after(:create) }
  end
end
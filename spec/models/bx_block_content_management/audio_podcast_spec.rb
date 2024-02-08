require 'rails_helper'

RSpec.describe BxBlockContentManagement::AudioPodcast, type: :model do
  context "association test" do
    it "should has_one image " do
      t = BxBlockContentManagement::AudioPodcast.reflect_on_association(:image)
      expect(t.macro).to eq(:has_one)
    end 
    it "should has_one audio " do
      t = BxBlockContentManagement::AudioPodcast.reflect_on_association(:audio)
      expect(t.macro).to eq(:has_one)
    end          
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:heading) }  
    end
    it{ should accept_nested_attributes_for :image }
    it{ should accept_nested_attributes_for :audio }
  end
end
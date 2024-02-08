require 'rails_helper'

RSpec.describe BxBlockContentManagement::CustomEmail, type: :model do
 
  context "association " do    
    it " has_one_attached image1 " do
      image1 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image1)
      expect(image1.macro).to eq(:has_one_attached)
    end  

    it " has_one_attached image2 " do
      image2 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image2)
      expect(image2.macro).to eq(:has_one_attached)
    end  

    it " has_one_attached image3 " do
      image3 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image3)
      expect(image3.macro).to eq(:has_one_attached)
    end  

    it " has_one_attached image4 " do
      image4 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image4)
      expect(image4.macro).to eq(:has_one_attached)
    end  

    it " has_one_attached image5 " do
      image5 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image5)
      expect(image5.macro).to eq(:has_one_attached)
    end  

    it " has_one_attached image6 " do
      image6 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image6)
      expect(image6.macro).to eq(:has_one_attached)
    end 

    it " has_one_attached image7 " do
      image7 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image7)
      expect(image7.macro).to eq(:has_one_attached)
    end 

     it " has_one_attached image8 " do
      image8 = BxBlockContentManagement::CustomEmail.reflect_on_attachment(:image8)
      expect(image8.macro).to eq(:has_one_attached)
    end 
  end

  describe "#Enum" do
    it { should define_enum_for(:email_type).with_values(%i[welcome_email activation_email draft_email order_placed_info ])}
    it { should define_enum_for(:valid_for).with_values(%i[all_users old_users new_users ])}
  end
end

require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::Availability, type: :model do
  context "association test" do
    it "should belongs_to service_provider " do
      t = BxBlockAppointmentManagement::Availability.reflect_on_association(:service_provider)
      expect(t.macro).to eq(:belongs_to)
    end 
    describe 'ensure validate of some attributes' do
      it { should validate_presence_of(:availability_date) }
      it { should validate_presence_of(:start_time) }
      it { should validate_presence_of(:end_time) }   
    end
    it { is_expected.to callback(:set_params).before(:save) }
    it { is_expected.to callback(:create_time_slots).after(:create) }
    it { is_expected.to callback(:update_slot_count).after(:create) }
  end
end
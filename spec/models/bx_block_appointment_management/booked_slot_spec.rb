require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::BookedSlot, type: :model do
  context "association test" do
    it "should belongs_to service_provider " do
      t = BxBlockAppointmentManagement::BookedSlot.reflect_on_association(:service_provider)
      expect(t.macro).to eq(:belongs_to)
    end 
  end
end

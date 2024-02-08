require 'rails_helper'
RSpec.describe BxBlockPlan::Plan, type: :model do
  context "enum test" do
   # it { should define_enum_for(:duration).with('3 Months', '6 Months','1 year') 
	   it 'test for enum ' do 
	   	 @plan = BxBlockPlan::Plan.create(duration:"3 Months")
	   	  expect(@plan.duration).to eq("3 Months")
	   end
   end
end
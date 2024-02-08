FactoryBot.define do
  factory :availability, class: "BxBlockAppointmentManagement::Availability" do
    service_provider_id { FactoryBot.create(:account).id }
    start_time { "10:00 AM" }
    end_time { "10:00 PM" }
    availability_date { DateTime.now.strftime("%d/%m/%Y") }
  end
end

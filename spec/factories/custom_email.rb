FactoryBot.define do
  factory :custom_email, class: "BxBlockContentManagement::CustomEmail" do
   description {"good_morning"}
   title {"hello"}
   email_type {"welcome_email"}
   timing_of_service {"10 am to 6 pm (monday to friday)"}
   address {"Site No. 191, SLV Complex, 2nd Sector, 27th Main, 19th Cross, HSR Layout, Bangalore - 560102"}
   email {"customercare@whitebook.co.in"}
   phone_no {"6364182702"}
  end
end

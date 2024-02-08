FactoryBot.define do
  factory :address, :class => BxBlockAddress::Address do
      email_address {"pawan@yopmail.com"}
      phone_number {"8745845164"}
      full_name {"pawan"}
      pincode {"450001"}
      city {"khandwa"}
      address {"c21 mall"}
      landmark {"xyz"}
      state {"mp"}
     
  end
end
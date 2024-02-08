FactoryBot.define do
  factory :brand, class: "BxBlockCatalogue::Brand" do
    name { generate :brand_name }
    currency { "USD" }
  end
end

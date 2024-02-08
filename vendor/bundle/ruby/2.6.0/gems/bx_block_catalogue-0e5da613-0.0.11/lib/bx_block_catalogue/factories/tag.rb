FactoryBot.define do
  factory :tag, class: "BxBlockCatalogue::Tag" do
    name { generate :tag_name }
  end
end

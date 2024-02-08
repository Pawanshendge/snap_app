FactoryBot.define do
  factory :group, class: "BxBlockAccountGroups::Group" do
    name { generate :group_name }
    settings { JSON.generate({stuff: [1, {b: 0}, "c"]}) }
  end
end

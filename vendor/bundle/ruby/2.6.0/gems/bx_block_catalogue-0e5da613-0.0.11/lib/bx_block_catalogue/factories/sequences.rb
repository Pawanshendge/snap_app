FactoryBot.define do
  sequence(:catalogue_name) { |n| "catalogue_#{n}" }
  sequence(:brand_name) { |n| "brand_#{n}" }
  sequence(:catalogue_variant_color_name) { |n|
    "catalogue_variant_color_#{n}"
  }
  sequence(:catalogue_variant_size_name) { |n|
    "catalogue_variant_size_#{n}"
  }
  sequence(:tag_name) { |n| "tag_name- #{n}" }
end

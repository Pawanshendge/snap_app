FactoryBot.define do
  factory :stories, class: "BxBlockStories::Story" do
    description{ "description" }
    valid_till{ "20/nov/3070" } 
    active{ true } 
    title{ "hello" }
    story_type{ "story" }
    link{}
  end
end
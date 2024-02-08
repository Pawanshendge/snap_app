module BxBlockStories
  class ErrorSerializer < BuilderBase::BaseSerializer
    attribute :errors do |story|
      story.errors.as_json
    end
  end
end

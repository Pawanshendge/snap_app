class BxBlockStories::DeactivePastStoriesJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info '=======================Job started================'
    stories = BxBlockStories::Story.all
    stories.each do |story|
      Rails.logger.info "=======================#{story.id}================"
      if Time.zone.now > story&.valid_till
        story.update_column(:active, false)
      end
      Rails.logger.info "=======================Failed: #{story.errors.inspect}================"
    end
    Rails.logger.info '=======================Job completed================'
  end
end

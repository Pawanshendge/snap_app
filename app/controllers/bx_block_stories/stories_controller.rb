module BxBlockStories
  class StoriesController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    # before_action :validate_json_web_token

    def active_stories
      active_stories = BxBlockStories::Story.where(active: true)
      if active_stories.present?
        render json: BxBlockStories::StorySerializer.new(active_stories).serializable_hash
      else
        render json: {data: []}, status: :ok
      end
    end

    def destroy
      story = BxBlockStories::Story.find_by(id: params[:id])
      return if story.nil?
      if story.destroy
        render json: { message: 'Story deleted successfully' }, status: :ok
      else
        render json: ErrorSerializer.new(story).serializable_hash,
               status: :unprocessable_entity
      end
    end
  end
end
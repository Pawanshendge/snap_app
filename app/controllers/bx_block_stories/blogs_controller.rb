module BxBlockStories
  class BlogsController < ApplicationController

    def active_blogs
      active_blogs = BxBlockStories::Blog.where(status: "active")
      if active_blogs.present?
        render json: BxBlockStories::BlogsSerializer.new(active_blogs).serializable_hash
      else
        render json: {data: []}, status: :ok
      end
    end

    def show
      @blog = BxBlockStories::Blog.find_by(url: params[:url])
      if @blog.present?
        render json: BxBlockStories::BlogsSerializer.new(@blog).serializable_hash
      else
        return render json: {errors: [{message: 'Blog not found'}]}, status: :ok
      end
    end
  end
end
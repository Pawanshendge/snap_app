ActiveAdmin.register BxBlockStories::Story, as: 'Stories' do
  require 'streamio-ffmpeg'

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :valid_till, :story_file, :active, :story_type, :title, :link

  # Filterable attributes on the index screen
  filter :valid_till

  index :download_links => false do
    selectable_column
    id_column
    column :story_file do |story|
      div :class => "story_img" do
        if story.story_file.attached?
          if BxBlockStories::Story::STORY_CONTENT_TYPE.include?(story.story_file&.content_type)
            image_tag(url_for(story.story_file), size: "150x120")
          else
            video_tag(url_for(story.story_file), size: "150x120", controls: true)
          end
        end
      end
    end
    column :valid_till
    column :story_type
    column :active
    actions
  end

  show do |story|
    attributes_table do
      row :id
      row :story_file do |story|
        div :class => "col-xs-4" do
          if story.story_file.attached?
            if BxBlockStories::Story::STORY_CONTENT_TYPE.include?(story.story_file&.content_type)
              image_tag(url_for(story.story_file), size: "150x120")
            else
              video_tag(url_for(story.story_file), size: "150x120", controls: true)
            end
          end
        end
      end
      row :story_type
      row :description
      row :valid_till
      row :active 
    end
  end

  form do |f|
    f.inputs do
      f.input :story_type
      hints = "<p style='padding-left:372px; font-size: 12px; margin-top:-15px;'><span>Max width of an image should be 991 px</span></p><p style='padding-left:372px; font-size: 12px;margin-top:-12px;'><span>Supported format for Images - .JPEG , .PNG, .BMP , .WEBP</span></p><p style='padding-left:372px; padding-bottom: 15px; font-size: 12px;margin-top:-10px;'><span>Supported format for Video - .MP4, .MOV, .WEBM, .MKV</span></p>".html_safe
      div class: "blog-div" do
        f.input :title
      end
      f.input :story_file, as: :file, hint: f.object.story_file.attached? ? (BxBlockStories::Story::STORY_CONTENT_TYPE.include?(f.object.story_file&.content_type) ? hints + image_tag(url_for(f.object.story_file), height: "150px", style: 'padding-left:372px;') : hints + video_tag(url_for(f.object.story_file), height: "150px", controls: true, style: 'padding-left:372px;')) : hints
      f.input :description
      div class: "blog-div" do
        f.input :link
      end
      f.input :valid_till, as: :datetime_picker, hint: 'Please add time in GMT/UTC'
      f.input :active
    end
    f.actions do
      f.action :submit
      f.cancel_link(action: 'index')
    end
  end

  controller do
    def create
      if params['bx_block_stories_story']['story_file'].present? && params['bx_block_stories_story']['valid_till'].present?
        file_path = params['bx_block_stories_story']['story_file'].tempfile.path
        movie = FFMPEG::Movie.new(file_path)
        if movie.valid?
          if movie.duration.to_i > 60.seconds
            redirect_to new_admin_story_path
            flash[:alert] = 'Please upload a video less then 1 minute'
          elsif movie.width > movie.height && (!movie.path.include?('.mp4') && !movie.path.include?('.mov') && !movie.path.include?('.webm') && !movie.path.include?('.mkv'))
            redirect_to new_admin_story_path
            flash[:alert] = 'Please upload a portait image'
          else
            super
          end
        end
      else
        super
      end
    end

    def update
      if params['bx_block_stories_story']['story_file'].present? && params['bx_block_stories_story']['valid_till'].present?
        file_path = params['bx_block_stories_story']['story_file'].tempfile.path
        movie = FFMPEG::Movie.new(file_path)
        if movie.valid?
          if movie.duration.to_i > 60.seconds
            redirect_to edit_admin_story_path
            flash[:alert] = 'Please upload a video less then 1 minute'
          elsif movie.width > movie.height && (!movie.path.include?('.mp4') && !movie.path.include?('.mov') && !movie.path.include?('.webm') && !movie.path.include?('.mkv'))
            redirect_to edit_admin_story_path
            flash[:alert] = 'Please upload a portait image'
          else
            super
          end
        end
      else
        super
      end
    end
  end
end

ActiveAdmin.register BxBlockStories::Blog, as: 'Blogs' do
  require 'streamio-ffmpeg'

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :title, :status, :blog_file

  form do |f|
    f.inputs do
      hints = "<p style='padding-left:372px; font-size: 12px; margin-top:-15px;'><span>Max width of an image should be 991 px</span></p><p style='padding-left:372px; font-size: 12px;margin-top:-12px;'><span>Supported format for Images - .JPEG , .PNG, .BMP , .WEBP</span></p><p style='padding-left:372px; padding-bottom: 15px; font-size: 12px;margin-top:-10px;'><span>Supported format for Video - .MP4, .MOV, .WEBM, .MKV</span></p>".html_safe

      f.input :blog_file, as: :file, hint: f.object.blog_file.attached? ? (BxBlockStories::Blog::BLOG_CONTENT_TYPE.include?(f.object.blog_file&.content_type) ? hints + image_tag(url_for(f.object.blog_file), size: "250x200", style: 'margin-left:372px;') : hints + video_tag(url_for(f.object.blog_file), height: "150px", controls: true, style: 'padding-left:372px;')) : hints
      f.input :title
      f.input :description
      f.input :status
    end
    f.actions do
      f.action :submit
      f.cancel_link(action: 'index')
    end
  end

  show do |blog|
    attributes_table do
      row :id
      row :blog_file do |blog|
        div :class => "col-xs-4" do
          if blog.blog_file.attached?
            if BxBlockStories::Blog::BLOG_CONTENT_TYPE.include?(blog.blog_file&.content_type)
              image_tag(url_for(blog.blog_file))
            else
              video_tag(url_for(blog.blog_file), controls: true)
            end
          end
        end
      end
      row :title
      row :description
      row :url
      row :status
    end
  end
end
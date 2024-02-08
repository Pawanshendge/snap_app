ActiveAdmin.register AccountBlock::DashboardMediaFile, as: 'Dashboard Media Files' do
  permit_params :name, :priority, :media_file

  index do
    selectable_column
    id_column
    column :name
    column :priority
    actions
  end

  form do |f|
    inputs 'Dashboard Media Files'do 
      f.input :name
      f.input :priority
      hints = "<p style='padding-left:372px; font-size: 12px;margin-top:-12px;'><span>Supported format for Images -  .JPEG , .PNG, .BMP , .WEBP</span></p><p style='padding-left:372px; padding-bottom: 15px; font-size: 12px;margin-top:-10px;'><span>Supported format for Video - .MP4, .MOV ,.WEBM ,  .MKV</span></p>".html_safe
      f.input :media_file, as: :file, :hint => object.media_file.present? ? hints + image_tag(url_for(object.media_file), style: 'width: 200px; margin-left: 372px;') : hints
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :priority
      row :media_file do |dashboard|
        ul do
          span do
            if dashboard.media_file.attached?
              file_formate = dashboard.media_file.content_type.split("/").first
              if file_formate == "video"
                if Rails.env.development?
                  video_tag url_for(dashboard.media_file), autoplay: false, controls: true
                  # image_tag url_for(dashboard.media_file), style: "max-width: 300px; max-height: 400px;"  ,class: 'img-wrap' 
                else
                  video_tag dashboard.media_file.service_url, autoplay: false, controls: true
                  # image_tag dashboard.media_file.service_url, style: "max-width: 300px; max-height: 400px;" ,class: 'img-wrap' if dashboard.media_file.attached?
                end
              elsif file_formate == "image"
                if Rails.env.development?
                  image_tag url_for(dashboard.media_file), style: "max-width: 300px; max-height: 400px;"  ,class: 'img-wrap' 
                else
                  image_tag dashboard.media_file.service_url, style: "max-width: 300px; max-height: 400px;" ,class: 'img-wrap' if dashboard.media_file.attached?
                end
              end
            end
          end
        end
      end
    end
  end
end

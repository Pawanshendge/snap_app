ActiveAdmin.register BxBlockContentManagement::CustomEmail, as: "CustomEmails" do

  permit_params :description, :title, :email_type, :address, :email, :timing_of_service, :phone_no, :image1, :image2, :image3, :image4, :image5, :image6, :image7, :image8

  form do |f|
    f.inputs do
      f.input :email_type
      # f.input :valid_for
      f.input :image1, as: :file
      f.input :image2, as: :file
      f.input :image3, as: :file
      f.input :image4, as: :file
      f.input :image5, as: :file
      f.input :image6, as: :file
      div class: "type-div" do
        f.input :image7, as: :file
        f.input :image8, as: :file
      end
      f.input :email
      f.input :timing_of_service
      f.input :phone_no
      f.input :title, as: :quill_editor
      f.input :description, as: :quill_editor
      f.input :address, as: :quill_editor

    end
    f.actions
  end

  show do |custom_emails|
    attributes_table do
      row :email_type
      # row :valid_for
      row :email
      row :phone_no
      row :timing_of_service
      row :title do |custom_emails|
        custom_emails&.title&.html_safe
      end
      row :description do |custom_emails|
        custom_emails&.description&.html_safe
      end
      row :address do |custom_emails|
        custom_emails&.address&.html_safe
      end
      row :image1 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image1), size: "100x100") if custom_emails.image1.attached?
        end  
      end
      row :image2 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image2), size: "500x500") if custom_emails.image2.attached?
        end 
      end
      row :image3 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image3), size: "500x500") if custom_emails.image3.attached?
        end 
      end
      row :image4 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image4), size: "500x500") if custom_emails.image4.attached?
        end 
      end
      row :image5 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image5), size: "500x500") if custom_emails.image5.attached?
        end 
      end
      row :image6 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image6), size: "500x500") if custom_emails.image6.attached?
        end 
      end
      row :image7 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image7), size: "500x500") if custom_emails.image7.attached?
        end 
      end
      row :image8 do |custom_emails|
        div do
          image_tag(url_for(custom_emails.image8), size: "500x500") if custom_emails.image8.attached?
        end 
      end
    end
  end
  
  index do
    selectable_column
    column :email_type
    column :email
    column :phone_no
    column :timing_of_service
    column :title do |custom_emails|
      custom_emails&.title&.html_safe
    end
    column :description do |custom_emails|
      custom_emails&.description&.html_safe
    end
    column :address do |custom_emails|
      custom_emails&.address&.html_safe
    end
    column :image1 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image1), size: "100x100") if custom_emails.image1.attached?
      end
    end
    column :image2 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image2), size: "100x100") if custom_emails.image2.attached?
      end
    end
    column :image3 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image3), size: "500x500") if custom_emails.image3.attached?
      end
    end
    column :image4 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image4), size: "100x100") if custom_emails.image4.attached?
      end
    end
    column :image5 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image5), size: "300x300") if custom_emails.image5.attached?
      end
    end
    column :image6 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image6), size: "300x300") if custom_emails.image6.attached?
      end
    end
    column :image7 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image7), size: "300x300") if custom_emails.image7.attached?
      end
    end
    column :image8 do |custom_emails|
      div do
        image_tag(url_for(custom_emails.image8), size: "300x300") if custom_emails.image8.attached?
      end
    end
    actions
  end
end

ActiveAdmin.register BxBlockAdmin::AboutUs, as: 'About Us' do
  permit_params :content, :description

  index do
    selectable_column
    id_column
    column :about_us do|about_us|
      truncate(about_us.content, omision: "...", length: 50)
    end
    column :description
    actions
  end

  form do |f|
    inputs 'About Us'do 
      f.input :content, as: :quill_editor, input_html: { data: { options: { modules: {   }, placeholder: 'Insert Images', theme: 'snow' } } }
      f.input :description, as: :quill_editor, input_html: { data: { options: { modules: {   }, placeholder: 'Insert Description...', theme: 'snow' } } }
    end
    f.actions
  end

  show do |about_us|
   attributes_table do
    div :class => "ql-editor" do
      about_us.content.html_safe
    end
    row :description
  end
 end
end

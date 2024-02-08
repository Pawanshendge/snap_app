ActiveAdmin.register BxBlockAdmin::PrivacyPolicy, as: 'Privacy Policy' do
  permit_params :content

  index do
    selectable_column
    id_column
    column :privacy_policy do |privacy_policy|
      truncate(privacy_policy.content, omision: "...", length: 50)
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      li do
        f.input :content, as: :quill_editor, input_html: { data: { options: { modules: {   }, placeholder: 'Type something...', theme: 'snow' } } }
      end
    end

    f.actions
  end

  show do |privacy_policy|
    div :class => "ql-editor" do
      privacy_policy.content.html_safe
    end
  end
end


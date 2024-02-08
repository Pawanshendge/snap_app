ActiveAdmin.register BxBlockAdmin::TermsAndCondition, as: 'Terms and Condition' do
  permit_params :content

  index do
    selectable_column
    id_column
    column :tnc do |tnc|
      truncate(tnc.content, omision: "...", length: 50)
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      li do
        f.input :content, as: :quill_editor, input_html: { data: { options: { modules: {  }, placeholder: 'Type something...', theme: 'snow' } } }
      end
    end

    f.actions
  end
  
  show do |tnc|
    div :class => "ql-editor" do
      tnc.content.html_safe
    end
  end
end

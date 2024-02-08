ActiveAdmin.register BxBlockAdmin::ReturnAndRefundPolicy, as: 'Return And Refund Policy' do
  permit_params :content

  index do
    selectable_column
    id_column
    column :rnr_policy do |rnr_policy|
      truncate(rnr_policy.content, omision: "...", length: 50)
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :content, as: :quill_editor, input_html: { data: { options: { modules: {   }, placeholder: 'Type something...', theme: 'snow' } } }
    end

    f.actions
  end

  show do |rnr_policy|
    div :class => "ql-editor" do
      rnr_policy.content.html_safe
    end
  end
end

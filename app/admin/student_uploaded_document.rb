ActiveAdmin.register StudentUploadedDocument do
  menu :label=>I18n.t('usms.menu.item.student_uploaded_document'), :parent => I18n.t('usms.menu.student'), :priority => 30
  config.batch_actions = false


  index do
    id_column
    column :name
    column :filename
  end

  filter :id
  filter :created_at
  filter :name
  filter :filename

  show do
    attributes_table do
      row :id
      row :name
      row :filename
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  permit_params do
    [:name,:filename,:data,:student_id]
  end

end

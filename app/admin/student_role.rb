ActiveAdmin.register StudentRole do
  menu :label=>I18n.t('usms.menu.item.student_role'), :parent => I18n.t('usms.menu.student'), :priority => 10
  config.batch_actions = false


  index do
    id_column
    column :name
  end

  filter :id
  filter :name

  show do
    attributes_table do
      row :id
      row :name
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
    end
    f.actions
  end

  permit_params :name

end

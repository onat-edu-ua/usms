ActiveAdmin.register Faculty do
  menu :label=>I18n.t('usms.menu.item.faculty'), :parent => I18n.t('usms.menu.student'), :priority => 11
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
    f.inputs do
      f.input :name
    end
    f.actions
  end

  permit_params :name

end

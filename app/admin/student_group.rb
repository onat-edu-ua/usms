ActiveAdmin.register StudentGroup do
  menu :label=>I18n.t('usms.menu.item.student_group'), :parent => I18n.t('usms.menu.student'), :priority => 10
  config.batch_actions = false


  index do
    id_column
    column :name
    column :course
  end

  filter :id
  filter :name
  filter :course

  show do
    attributes_table do
      row :id
      row :name
      row :course
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :course
    end
    f.actions
  end

  permit_params do
    [:name,:course_id]
  end

end

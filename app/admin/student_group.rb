ActiveAdmin.register StudentGroup do
  menu :label=>I18n.t('usms.menu.item.student_group'), :parent => I18n.t('usms.menu.student'), :priority => 10
  config.batch_actions = false


  index do
    id_column
    column :name
    column :course
    column :faculty
  end

  filter :id
  filter :name
  filter :course
  filter :faculty

  show do
    attributes_table do
      row :id
      row :name
      row :course
      row :faculty
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :course
      f.input :faculty
    end
    f.actions
  end

  permit_params do
    [:name, :course_id, :faculty_id]
  end

end

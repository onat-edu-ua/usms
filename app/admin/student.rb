ActiveAdmin.register Student do
  menu parent: "Students",  priority: 10
  config.batch_actions = false


  index do
    id_column
    column :last_name
    column :first_name
    column :middle_name
  end

  filter :id
  filter :first_name

  show do
    attributes_table do
      row :id
      row :last_name
      row :first_name
      row :middle_name
    end
  end

  form do |f|
    f.inputs do
      f.input :last_name
      f.input :first_name
      f.input :middle_name
    end
    f.actions
  end

  permit_params do
    [:last_name,:first_name,:middle_name]
  end

end

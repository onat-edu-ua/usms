ActiveAdmin.register Student do
  menu :label=>I18n.t('usms.menu.item.student'), :parent => I18n.t('usms.menu.student'), :priority => 10
  config.batch_actions = true
  actions :index, :destroy, :create, :new, :edit, :update, :show


  index do
    selectable_column
    id_column
    actions
    column :last_name
    column :first_name
    column :middle_name
    column :ticket_num
    column :phone
    column :email
    column :group
    column :login
    column :role do |r|
      r.roles_list
    end
  end

  filter :id
  filter :last_name
  filter :ticket_num
  filter :group_course_id_eq , as: :select, input_html: {class: 'chosen'}, collection: -> { StudentCourse.collection }
  filter :group, as: :select, input_html: {class: 'chosen', multiple: false}
  filter :login
  filter :phone
  filter :email
  filter :login
  filter :role, as: :select, input_html: {class: 'chosen', multiple: true}, collection: -> { StudentRole.collection }

  show do
    attributes_table do
      row :id
      row :last_name
      row :first_name
      row :middle_name
      row :ticket_num
      row :phone
      row :email
      row :group
      row :login
      row :password
      row :role do |r|
        r.roles_list
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :ticket_num
      f.input :phone
      f.input :email
      f.input :group, as: :select, input_html: {class: 'chosen', multiple: false}
      f.input :role_id, as: :select, input_html: {class: 'chosen', multiple: true}, collection: StudentRole.collection
    end
    f.actions
  end

  sidebar(I18n.t('usms.menu.item.student'), :only=>[:show, :edit]) do

  end


  permit_params :last_name,:first_name,:middle_name,:ticket_num,:group_id,:phone,:email, role_id: []

end

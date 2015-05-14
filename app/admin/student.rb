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
    column :hostel
    column :hostel_room
  end

  filter :id
  filter :fio_contains, label: I18n.t('usms.filters.students.fio')
  filter :ticket_num
  filter :group_course_id_eq , label: I18n.t('usms.filters.students.course'), as: :select, input_html: {class: 'chosen'}, collection: -> { StudentCourse.collection }
  filter :group_faculty_id_eq, label: I18n.t('usms.filters.students.faculty'), as: :select, input_html: {class: 'chosen'}, collection: -> { Faculty.collection }
  filter :group, as: :select, input_html: {class: 'chosen', multiple: false}
  filter :login
  filter :phone
  filter :email
  filter :login
  filter :role, as: :select, input_html: {class: 'chosen', multiple: true}, collection: -> { StudentRole.collection }
  filter :hostel, as: :select, input_html: {class: 'chosen', multiple: false}
  filter :hostel_room

  show do |s|
    tabs do
      tab "MAIN" do
        attributes_table_for s do
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
          row :hostel
          row :hostel_room
        end
      end
      tab "Parents" do
        attributes_table_for s do
          row :parents_address
          row :parents_phone
        end
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
      f.input :hostel, as: :select, input_html: {class: 'chosen', multiple: false}
      f.input :hostel_room
      f.input :parents_address
      f.input :parents_phone
    end
    f.actions
  end

  sidebar(I18n.t('usms.menu.item.student'), :only=>[:show, :edit]) do

  end


  permit_params :last_name,:first_name,:middle_name,:ticket_num,:group_id,
                :parents_phone, :parents_address,
                :phone,:email, :hostel_id, :hostel_room, role_id: []

end

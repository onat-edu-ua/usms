ActiveAdmin.register AdminUser do
  menu :label=>I18n.t('usms.menu.item.operator'), :parent => I18n.t('usms.menu.system'), :priority => 10
  permit_params :email, :password, :password_confirmation
  config.batch_actions = false


  index do
    id_column
    actions
    column :email
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    column :updated_at
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do |s|
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end

end

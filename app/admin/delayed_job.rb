ActiveAdmin.register Delayed::Job, as: 'Job' do
  menu :label=>I18n.t('usms.menu.item.delayed_job'), :parent => I18n.t('usms.menu.system'), :priority => 30
  config.batch_actions=false

  actions :index

  index do
    column :id
    column :queue
    column :priority
    column :attempts
    column :failed_at
    column :run_at
    column :created_at
    column :locked_by
    column :locked_at
  end

  filter :id

end
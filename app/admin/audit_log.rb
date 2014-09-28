ActiveAdmin.register AuditLog do

   menu :parent => "Main",  :priority => 10
   menu :label=>I18n.t('usms.menu.item.audit_log'), :parent => I18n.t('usms.menu.system'), :priority => 20

   #controller.authorize_resource

   config.batch_actions = false


   actions :index , :show


   filter :item_type
   filter :event,:as => :select, :collection => [['create','create'], ['destroy','destroy'], ['update','update']]
   filter :whodunnit
   filter :created_at
   filter :ip

#   scope :all, :default => true
#   scope :created
#   scope :updated
#   scope :destroyed



#  controller do
#    def scoped_collection
#          Version.includes(:item)
#    end
#  end

  show do |version|
      attributes_table do
        row :id
        row :item_type
        row :item
        row :event
        row :whodunnit
        row :date do
          version.created_at
        end
        row :ip

        panel "Values before event" do
          obj = version.reify
          attributes_table_for  obj  do
               row :id
                obj.class.content_columns.each do |col|
                  row col.name.to_sym
                end

          end
        end unless version.reify.nil?
      end
      active_admin_comments
  end

   index do


     id_column
     column :item_type
     column 'Item', :sortable => :item_id do  |v|

        text = "".html_safe
        text << v.item_id.to_s
        unless v.item.nil?
           text << " "
           #text << link_to(v.item.display_name , v.item.permalink(:version => v.id))
        end
       text
     end

     column :event
     column :created_at
     column("Who Id", :sortable => 'whodunnit') do |version|
        version.whodunnit
     end

     column("Who", :sortable => 'whodunnit') do |version|
        #whodunit_link(version.whodunnit)
     end

     column :ip

   end





end
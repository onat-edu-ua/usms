class AuditLog < PaperTrail::Version

    #attr_accessible :ip, :event, :object, :whodunnit
    scope :destroyed, where(:event => "destroy")
    scope :updated, where(:event => "update")
    scope :created, where(:event => "create")

end

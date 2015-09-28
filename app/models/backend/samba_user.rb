class Backend::SambaUser
  include ActiveModel::Model
  attr_accessor :id, :login, :display_name, :first_name, :last_name, :phone, :email, :password

  def base
    SAMBA_CONFIG['base']
  end

  # def set_id(dn, id, login)
  #   ops=[
  #     [:add, :object_class, "posixAccount"],
  #     [:replace, :uidNumber, id]
  #   ]
  #   @client.modify(dn: dn, operations: ops)
  # end

  def sync
    @client = Net::LDAP.new
    @client.host = SAMBA_CONFIG['host']
    @client.base = SAMBA_CONFIG['base']
    @client.port = SAMBA_CONFIG['port']
    @client.auth(SAMBA_CONFIG['bind_dn'], SAMBA_CONFIG['bind_password'])

    if @client.bind
      p "Connected to Samba"
#      p @client.get_operation_result
    else
      p "Not Connected"
      p @client.get_operation_result
    end

    dn="CN=#{login},CN=Users,#{self.base}"

    attrs = {
        :uidNumber => id.to_s,
        :uid => login,
        :objectclass => ["posixAccount", "top", "person", "organizationalPerson", "user"],
        :cn => login,
        :sn => last_name,
        :givenname => first_name,
        :displayname => display_name,
        :name => login,
        :samaccountname => login,
        :userpassword => password,
        :title => "Student",
        :mail => email,
        :mobile => phone,
        :useraccountcontrol => 512.to_s
    }
    p attrs
#      ldap.add(:dn => "ou=marketing,#{BASE}", :attributes => { :ou => "marketing", :objectclass => "organizationalUnit" })
#      ldap.add(:dn => BASIC_USER, :attributes => { :cn => "jsmith", :objectclass => "inetOrgPerson", :sn => "Smith" })


    filter = Net::LDAP::Filter.eq('uidNumber', id.to_s)
    result=@client.search(:base => base, :filter => filter, :return_result => true)[0]

    p @client.get_operation_result

    if !result.nil?
      @client.delete(dn: dn)
      p "deleted"
      #   @client.delete(dn :dn)
      #   attrs.delete(:cn)
      #   attrs.delete(:name)
      #   ops=[]
      #   attrs.each do |k,v|
      #     ops << [:replace,k,v]
      #   end
      # @client.modify(dn: dn, operations: ops)
      # p @client.get_operation_result
      # @client.rename(olddn: result.dn, :newrdn => "CN=#{login}")
      p @client.get_operation_result
    end
    p "not found"
    @client.add(dn: dn, attributes: attrs)
    p @client.get_operation_result


    #
    # # set_id(dn, id, login)
    # if @client.get_operation_result.code != 0
    #   p "Failed to add user. Try update"
    #   p @client.get_operation_result
    #   if @client.get_operation_result.code == 68 ## user already exists
    #     p "User already exists"
    #     filter = Net::LDAP::Filter.eq('samaccountname', loginid)
    #     result=@client.search(:base => base, :filter => filter, :return_result => true)[0]
    #     if !result.nil?
    #       p "record found"
    #       p @client.get_operation_result
    #       ops=[]
    #       attrs.each do |k,v|
    #         ops << [:replace,k,v]
    #       end
    #       @client.modify(dn: dn, operations: ops)
    #       if @client.get_operation_result.code != 0
    #         p attrs
    #         p "Update failed"
    #         p @client.get_operation_result
    #       end
    #     end
    #   end
    # else
    #   puts "Added user"
    #   p @client.get_operation_result
    # end

  end

end

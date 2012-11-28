require 'casserver/loggers/base'

begin
  require 'active_record'
rescue LoadError
  require 'rubygems'
  require 'active_record'
end

class CASServer::Loggers::SQL < CASServer::Loggers::Base
  def self.setup(options)
    raise CASServer::LoggerError, "Invalid logger configuration!" unless options[:database]

    signin_model_name = "CASLogin_#{options[:index]}"
    $LOG.debug "CREATING SIGNIN MODEL #{signin_model_name}"

    class_eval %{
      class #{signin_model_name} < ActiveRecord::Base
      end
    }

    @signin_model = const_get(signin_model_name)
    @signin_model.establish_connection(options[:database])
    @signin_model.set_table_name(options[:signins_table_name] || 'logins')
    @signin_model.inheritance_column = 'no_inheritance_column' if options[:ignore_type_column]
      
      
    signout_model_name = "CASLogout_#{options[:index]}"
    $LOG.debug "CREATING SIGNOUT MODEL #{signout_model_name}"

    class_eval %{
      class #{signout_model_name} < ActiveRecord::Base
      end
    }

    @signout_model = const_get(signout_model_name)
    @signout_model.establish_connection(options[:database])
    @signout_model.set_table_name(options[:signouts_table_name] || 'logouts')
    @signout_model.inheritance_column = 'no_inheritance_column' if options[:ignore_type_column]
  end
  
  def self.signout_model
    @signout_model
  end
  
  def self.signin_model
    @signin_model
  end
  
  def signin_model
    self.class.signin_model
  end
  
  def signouts_model
    self.class.signout_model
  end
  
  def login(user)
    @username = user[:username]
    @extra_attributes = user[:extra_attributes]
    @service = user[:service]
    
    record = signin_model.new
    
    record.username = @username
    record.service = @service
    record.timestamp = DateTime.now
    
    record.save
  end
  
  def logout(user)
    @username = user[:username]
    @extra_attributes = user[:extra_attributes]
   
    record = signout_model.new
   
    record.username = @username
    record.timestamp = DateTime.now
   
    record.save
  end
end
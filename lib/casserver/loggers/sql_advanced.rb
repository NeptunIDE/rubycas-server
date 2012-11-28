require 'casserver/loggers/sql'

begin
  require 'active_record'
rescue LoadError
  require 'rubygems'
  require 'active_record'
end

class CASServer::Loggers::SQLAdvanced < CASServer::Loggers::SQL
  def login(user)
      @username = user[:username]
      @extra_attributes = user[:extra_attributes]
      @service = user[:service]

      @request = user[:request]
              
      record = signin_model.new
      
      record.username = @username
      record.service = @service
      record.timestamp = DateTime.now
      
      record.domain = @request["HTTP_HOST"]
      
      record.ip = @request["REMOTE_ADDR"]
      record.real_ip = record.ip
      
      record.real_ip = @request["X_FORWARDED_FOR"] unless @request["X_FORWARDED_FOR"].nil?
      
      record.user_agent = @request["HTTP_USER_AGENT"]
      record.referer = @request["HTTP_REFERER"]
      record.accepted_languages = @request["HTTP_ACCEPT_LANGUAGE"]
      
      record.save
    end
end
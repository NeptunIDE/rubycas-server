module CASServer
	module Loggers
		class Base
    	attr_accessor :options
    		
    	def configure(options)
    	  raise ArgumentError, "options must be a HashWithIndifferentAccess" unless options.kind_of? HashWithIndifferentAccess
    	  @options = options.dup
    	end
    	
      def login(user)
        raise NotImplementedError, "This method must be implemented by a class extending #{self.class}"
      end	
      
      def logout(user)
        raise NotImplementedError, "This method must be implemented by a class extending #{self.class}"
      end
    	
	  end
	  
    class LoggerError < Exception
    end
	end
end
    
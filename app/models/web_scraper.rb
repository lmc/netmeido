module WebScraper
  
  def self.included(base)
    base.send(:extend, ClassMethods)
    #base.send(:include,InstanceMethods)
  end
  
  module ClassMethods
    
    def web_client
      Mechanize.new do |agent|
        
        yield(agent) if block_given?
      end
    end
    
  end
  
end
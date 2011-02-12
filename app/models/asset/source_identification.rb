class Asset
  module SourceIdentification
    
    def self.included(base)
      base.before_save :fetch_data_from_source!, :if => :source_detected?
    end
    
    def fetch_data_from_source!
      
    end
    
    def source_detected?
      
    end
  end
end
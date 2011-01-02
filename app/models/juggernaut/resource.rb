module Juggernaut
  module Resource
    
    def self.included(base)
      base.after_save do |instance|
        instance.juggernaut_event(:after_save)
      end
    end
    
    def juggernaut_channel
      "/#{self.class.name.underscore.pluralize}/#{self.id}"
    end
    
    def juggernaut_event(event_name,data = self.attributes)
      Juggernaut.publish(juggernaut_channel,{:event_name => event_name,:data => data})
    end
  end
end
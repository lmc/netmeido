module FakeActiveRecord
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include,InstanceMethods)
  end
  
  module ClassMethods
    def model_name
      ActiveModel::Name.new(self)
    end
  end
  
  module InstanceMethods
    def to_key
      [self.class.name.underscore]
    end
  end
end
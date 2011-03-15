class TimeCapsuleInterface::Archive
  include Mongoid::Document
  
  field :archive_created_at, :type => DateTime, :default => proc { Time.now }
  
  field :period_span,        :type => String
  field :period_start,       :type => DateTime
  field :interface,          :type => String
  
  field :bytes_in_dx,        :type => Integer
  field :bytes_out_dx,       :type => Integer
  field :errors_in_dx,       :type => Integer
  field :errors_out_dx,      :type => Integer
  
  index 'archive_created_at'#, Mongo::DESCENDING
  
  index 'period_span'
  index 'period_start'#, Mongo::DESCENDING
  index 'interface'
end
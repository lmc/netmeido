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
  
  
  def self.search(params)
    criteria = self.where(:period_start.gt => params[:period_start_gt], :period_start.lt => params[:period_start_lt])
    criteria.where(:interface => search_interfaces(params[:interfaces])) unless params[:interfaces].to_s == "all"
    criteria.where(:period_span => '5 minutes')
    criteria.descending(:period_start)
    criteria
  end
  
  def self.to_json_flot(dataset,options = {})
    TimeCapsuleInterface.to_json_flot(dataset,options.merge(:time_attribute => :period_start))
  end
  
end
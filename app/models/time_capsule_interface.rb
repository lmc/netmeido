class TimeCapsuleInterface
  include Mongoid::Document
  
  field :created_at,    :type => DateTime, :default => proc { Time.now }
  field :interface,     :type => String
                        
  field :up,            :type => Boolean
  field :bytes_in,      :type => Integer
  field :bytes_out,     :type => Integer
  field :errors_in,     :type => Integer
  field :errors_out,    :type => Integer
                        
  field :bytes_in_dx,   :type => Integer
  field :bytes_out_dx,  :type => Integer
  field :errors_in_dx,  :type => Integer
  field :errors_out_dx, :type => Integer
  
  index :created_at, Mongo::DESCENDING
  index :interface
  
  before_save :calculate_deltas
  
  DELTA_TARGET_FIELDS = %w(bytes_in bytes_out errors_in errors_out)
  INTERFACES = %w(mgi0 mgi1 mv0 mv1 lo0 wlan0 wlan1 bridge0)
  
  def self.delta_target_array
    DELTA_TARGET_FIELDS.map { |field| [field,"#{field}_dx"] }
  end
  
  def self.search_interfaces(param)
    if param == :all
      INTERFACES
    elsif param.is_a?(Array)
      param
    else
      raise "bad search_interface argument", ArgumentError
    end
  end
  
  def self.search(params)
    criteria = self.where(:created_at.gt => params[:created_at_gt], :created_at.lt => params[:created_at_lt])
    criteria.where(:interface => search_interfaces(params[:interfaces])) unless params[:interfaces].to_s == "all"
    criteria.descending(:created_at)
    criteria
  end
  
  def last_interface_entry
    @last_interface_entry ||= self.class.where(:interface => self.interface, :created_at.lt => self.created_at).
      descending(:created_at).limit(1).first
    @last_interface_entry
  end
  
  def calculate_deltas
    return unless last_interface_entry
    self.class.delta_target_array.each do |field,delta_field|
      self[delta_field] = calculate_delta_with_overflow_check(self[field],last_interface_entry[field])
    end
  end
  
  #FIXME: handle overflow checking
  def calculate_delta_with_overflow_check(current,last)
    current - last
  end
  
  #[ { label: "Foo", data: [ [10, 1], [17, -14], [30, 5] ] }, { ... } ]
  def self.to_json_flot(dataset)
    attributes = %w(bytes_in_dx bytes_out_dx)
    flot_data = Hash.new { |hash,key| hash[key] = [] }
    
    dataset.each do |data|
      attributes.each do |attribute|
        flot_data["#{data.interface}_#{attribute}"] << [data.created_at.to_i,data[attribute]]
      end
    end
    
    flot_data = flot_data.map do |label,data|
      {:label => label, :data => data}
    end
    
    flot_data.to_json
  end
end

class TimeCapsuleInterface::SearchOptions < OpenStruct
  
  def initialize(params)
    params.reverse_merge!(
      :created_at_gt => 1.minute.ago,
      :created_at_lt => Time.now,
      :interfaces    => :all
    )
    super(params)
  end
  
  def [](key)
    send(key)
  end
  
end
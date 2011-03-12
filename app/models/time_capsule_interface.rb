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
  
  before_save :calculate_deltas
  
  DELTA_TARGET_FIELDS = %w(bytes_in bytes_out errors_in errors_out)
  def self.delta_target_array
    DELTA_TARGET_FIELDS.map { |field| [field,"#{field}_dx"] }
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
end
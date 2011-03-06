class TimeCapsule < SnmpClient
  INTERFACES = {
    5 => "wifi",
    6 => "wan"
  } #Maybe!!
  
  attr_accessor :interface_stats
  
  #TODO!: Deal with a "cannot connect" error
  def parse!
    self.interface_stats = Hash.new { |hash,key| hash[key] = {} }
    
    interface_names = Hash[self.raw_output.scan(/IF-MIB::ifDescr.(\d+) = STRING: (\w+)/m)]
    interface_types = Hash[self.raw_output.scan(/IF-MIB::ifType.(\d+) = INTEGER: ([a-zA-Z0-9\(\)]+)/)]
    mac_addresses   = Hash[self.raw_output.scan(/IF-MIB::ifPhysAddress.(\d+) = STRING: ([0-9a-f:]+)/)]
    
    link_states     = Hash[self.raw_output.scan(/IF-MIB::ifOperStatus.(\d+) = INTEGER: (\w+)\(\d\)/)]
    octets_in       = Hash[self.raw_output.scan(/IF-MIB::ifInOctets.(\d+) = Counter32: (\d+)/)]
    octets_out      = Hash[self.raw_output.scan(/IF-MIB::ifOutOctets.(\d+) = Counter32: (\d+)/)]
    errors_in       = Hash[self.raw_output.scan(/IF-MIB::ifInErrors.(\d+) = Counter32: (\d+)/)]
    errors_out      = Hash[self.raw_output.scan(/IF-MIB::ifOutErrors.(\d+) = Counter32: (\d+)/)]
    
    interface_names.keys.each do |index|
      self.interface_stats[index][:name]        = interface_names[index]
      self.interface_stats[index][:type]        = interface_types[index]
      self.interface_stats[index][:mac]         = mac_addresses[index]
      self.interface_stats[index][:in]          = octets_in[index].to_i
      self.interface_stats[index][:out]         = octets_out[index].to_i
      self.interface_stats[index][:errors_in]   = errors_in[index].to_i
      self.interface_stats[index][:errors_out]  = errors_out[index].to_i
      self.interface_stats[index][:up]          = link_states[index] == "up"
    end
    
    self.interface_stats
  end
  
end
class SnmpClient
  attr_accessor :host
  attr_accessor :raw_output
  
  def initialize(host)
    self.host = host
  end
  
  def fetch!
    self.raw_output = `#{self.class.command(self.host)}`
    parse!
  end
  
  def parse!
  end
  
  
  protected
  
  def self.command(host)
    "snmpwalk -c public #{host}"
  end
  
end
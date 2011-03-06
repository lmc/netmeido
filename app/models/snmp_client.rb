class SnmpClient
  TIMEOUT = 3.0
  
  attr_accessor :host
  attr_accessor :success
  attr_accessor :raw_output
  
  def initialize(host)
    self.host = host
  end
  
  def fetch!
    begin
      Timeout.timeout(TIMEOUT) do
        self.raw_output = self.class.snmpwalk(self.host)
        self.success = !self.raw_output.match(/^Timeout:/)
      end
    rescue Timeout::Error
      self.raw_output = ""
      self.success = false
    end
  end
  
  def parse!
  end
  
  
  protected
  
  def self.snmpwalk(host)
    `#{"snmpwalk -c public #{host} 2>&1"}`
  end
  
end
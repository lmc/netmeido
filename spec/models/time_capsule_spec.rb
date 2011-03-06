require 'spec_helper'

describe TimeCapsule do
  
  describe "Success/Failure states" do
    
    it "should set success properly on success" do
      TimeCapsule.should_receive(:snmpwalk).with("192.168.0.2").
        and_return(File.read(Rails.root.join('spec','fixtures','snmpwalk_time_capsule.txt')))
      
      time_capsule = TimeCapsule.new("192.168.0.2")
      time_capsule.fetch!
      time_capsule.success.should be_true
    end
    
    it "should set success properly on failure" do
      TimeCapsule.should_receive(:snmpwalk).with("192.168.0.2").
        and_return(File.read(Rails.root.join('spec','fixtures','snmpwalk_time_capsule_failure.txt')))
      
      time_capsule = TimeCapsule.new("192.168.0.2")
      time_capsule.fetch!
      time_capsule.success.should be_false
    end
    
    it "should set success properly on timeout" do
      TimeCapsule.should_receive(:snmpwalk).with("192.168.0.2").
        and_raise(Timeout::Error)
        
      time_capsule = TimeCapsule.new("192.168.0.2")
      time_capsule.fetch!
      time_capsule.success.should be_false
    end
    
  end
  
  describe "Parsing data" do
    before(:each) do
      TimeCapsule.should_receive(:snmpwalk).with("192.168.0.2").
        and_return(File.read(Rails.root.join('spec','fixtures','snmpwalk_time_capsule.txt')))
      @time_capsule = TimeCapsule.new("192.168.0.2")
      @time_capsule.fetch!
      @time_capsule.parse!
      @data = @time_capsule.interface_stats
    end
    
    it "should parse the expected amount of interfaces" do
      @data.should have(8).keys
    end
    
    it "should parse data for the first interface correctly" do
      @data["1"][:name].should        == "mgi0"
      @data["1"][:type].should        == "ethernetCsmacd(6)"
      @data["1"][:mac].should         == "0:26:bb:6c:3f:83"
      @data["1"][:in].should          == 689150226
      @data["1"][:out].should         == 165828714
      @data["1"][:errors_in].should   == 0
      @data["1"][:errors_out].should  == 0
      @data["1"][:up].should          == true
    end
  end
  
end
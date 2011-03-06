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
    
end
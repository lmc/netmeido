require 'spec_helper'

describe TimeCapsuleInterface do
  
  it "should handle overflows properly" do
    @tc1 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,0), :bytes_in => 4294967291)
    @tc2 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,1), :bytes_in => 4)
    @tc2.stub!(:last_interface_entry).and_return(@tc1)
    
    @tc2.calculate_deltas
    @tc2.bytes_in_dx.should == 8
  end
  
end
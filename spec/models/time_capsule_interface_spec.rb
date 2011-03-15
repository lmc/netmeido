require 'spec_helper'

describe TimeCapsuleInterface do
  
  describe "calculating deltas" do
    
    it "should calulate deltas" do
      @tc1 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,0), :bytes_in => 0)
      @tc2 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,2), :bytes_in => 4)
      @tc2.stub!(:last_interface_entry).and_return(@tc1)

      @tc2.calculate_deltas
      @tc2.bytes_in_dx.should == 2
    end
    
    it "should handle overflows properly" do
      @tc1 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,0), :bytes_in => 4294967291)
      @tc2 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,1), :bytes_in => 4)
      @tc2.stub!(:last_interface_entry).and_return(@tc1)

      @tc2.calculate_deltas
      @tc2.bytes_in_dx.should == 8
    end

    it "should calculate delta when values haven't changed between entries" do
      @tc1 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,0), :bytes_in => 4)
      @tc2 = TimeCapsuleInterface.new(:created_at => Time.local(2011,3,14,15,0,1), :bytes_in => 4)
      @tc2.stub!(:last_interface_entry).and_return(@tc1)

      @tc2.calculate_deltas
      @tc2.bytes_in_dx.should == 0
    end

  end
  
end
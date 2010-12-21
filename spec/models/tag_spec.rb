require 'spec_helper'

describe Tag do
  describe "should normalize tag titles" do
    it "should normalize basic tag titles" do
      Tag.normalize_title_string("Test Tag").should == "test_tag"
    end
  end
end

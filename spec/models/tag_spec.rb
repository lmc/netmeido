require 'spec_helper'

describe Tag do
  describe "should normalize tag titles" do
    it "should normalize basic tag titles" do
      Tag.normalize_title_string("Test_Tag").should == "test_tag"
      Tag.normalize_title_string("A_More_complex_tag_(With_Disambiguation)").should == "a_more_complex_tag_(with_disambiguation)"
    end
    it "should normalize tag titles on assignment" do
      tag = Tag.new(:title => "HerpDerp")
      tag.title.should == "herpderp"
    end
  end
end

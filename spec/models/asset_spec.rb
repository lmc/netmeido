require 'spec_helper'

describe Asset do
  before(:each) do
    @asset = Asset.new
  end
  
  describe "Files" do
    it "should accept a file on :file"
    it "should thumbnail compatible files"
    it "should show icon for un-thumbnailable files"
    it "should be uploaded to S3"
    
    describe "Background jobs" do
      it "should upload to S3"
      it "should generate thumbnails"
    end
  end
  
  describe "Tags" do
    it "should get tag titles" do
      @asset.tags.build(:title => "tag_1")
      @asset.tags.build(:title => "tag_2")
      @asset.tag_titles.should == "tag_1 tag_2"
    end
    
    it "should normalize and create tags from tag_titles" do
      @asset.tag_titles = "tag_1 Tag_2 herp-derp_tag"
      tag_titles = @asset.tags.map(&:title)
      tag_titles.should include "tag_1"
      tag_titles.should include "tag_2"
      tag_titles.should include "herp-derp_tag"
    end
  end
end

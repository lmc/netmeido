require 'spec_helper'

describe Asset do
  before(:each) do
    @asset = Asset.new
  end
  
  describe "Files" do
    it "should accept a file on :file"
    it "should thumbnail compatible files" do
      @asset = Asset.new(:file => asset_fixture_file('test.jpg'))
      #@asset.
    end
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
    
    it "should save tags on asset save" do
      Tag.where(:title.in => ['lovely_tag','second_lovely_tag']).destroy_all
      
      #FIXME?: I think the accessor should be atomic, nothing changes until .save is called
      lambda {
        @asset.tag_titles = "lovely_tag"
        @asset.save
      }.should change(Tag,:count).by(1)
      
      lambda {
        @asset.update_attributes(:tag_titles => 'second_lovely_tag')
      }.should change(Tag,:count).by(1)
    end
    
    it "should use the same tag for each asset" do
      @asset_1 = Asset.create(:tag_titles => 'herp')
      @asset_2 = Asset.create(:tag_titles => 'herp')
      
      @asset_1.tags.size.should == 1
      @asset_1.tags[0].title.should == 'herp'
      
      @asset_1.tags[0].should == @asset_2.tags[0]
    end
  end
end

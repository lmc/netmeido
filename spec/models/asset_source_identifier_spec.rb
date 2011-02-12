require 'spec_helper'

describe AssetSourceIdentifier do
  
  it "should ignore extension for filename" do
    source_ider = AssetSourceIdentifier.new("e4cfac7e6b75c7751cb1b4198b0629a0.jpg")
    File.extname(source_ider.filename).should be_blank
  end
  
  it "should identify possible sources" do
    source_ider = AssetSourceIdentifier.new("e4cfac7e6b75c7751cb1b4198b0629a0.jpg")
    source_ider.possible_sources.should include :booru_file
  end
  
end
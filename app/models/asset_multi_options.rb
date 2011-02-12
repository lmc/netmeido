class AssetMultiOptions
  include FakeActiveRecord
  attr_accessor :tag_titles, :group, :group_title
  
  def initialize(params = {})
    params.reverse_merge!(
      :tag_titles  => '',
      :group       => true,
      :group_title => self.class.default_upload_session_name
    )
    self.tag_titles = params[:tag_titles]
  end
  
  def self.default_upload_session_name
    time = Time.now
    "upload_session_#{time.strftime('%Y-%m-%d-%H-M')}--#{(time.sec+(rand*3600).to_i)%1000}"
  end
  
end
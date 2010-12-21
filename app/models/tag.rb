class Tag
  include Mongoid::Document
  field :title, :type => String
  
  referenced_in :asset, :inverse_of => :tags
  
  #Normalized tags are seperated by spaces, with inter-tag spaces using underscores
  #a_tag
  #a_more_complex_tag_(with_disambiguation)
  def self.normalize_title_string(title)
    title.downcase.gsub(/\s+/,'_').gsub(/[^A-Za-z0-9_\(\)]/,'')
  end
end

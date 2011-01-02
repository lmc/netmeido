class Asset
  include Mongoid::Document
  field :file_filename
  field :created_at, :type => DateTime, :default => lambda { Time.zone.now }
  
  mount_uploader :file, AssetUploader
  
  include TagsAccessors
  references_many :tags, :stored_as => :array
  
  #new defaults here
  def to_json(*arguments)
    options = arguments.extract_options!
    options[:methods] ||= []
    options[:methods]  += [:tag_titles]
    super(*(arguments + [options]))
  end
  
end

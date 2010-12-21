class Asset
  include Mongoid::Document
  field :file_filename
  field :created_at, :type => DateTime, :default => lambda { Time.zone.now }
  
  mount_uploader :file, AssetUploader
  
  references_many :tags
end

class Asset
  include Mongoid::Document
  mount_uploader :file, AssetUploader
  
  field :file_filename
  field :created_at, :type => DateTime, :default => lambda { Time.zone.now }
  
end

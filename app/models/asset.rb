class Asset
  include Mongoid::Document
  mount_uploader :file, AssetUploader
end

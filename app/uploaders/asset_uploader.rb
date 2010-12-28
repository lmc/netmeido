# encoding: utf-8
class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :s3
  
  version :thumb do
    process :resize_to_fill => [400,400]
  end

  def store_dir
    "data/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end

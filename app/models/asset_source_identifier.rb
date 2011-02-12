class AssetSourceIdentifier
  FILENAME_PATTERNS = {
    :booru_file => /\A[0-9a-f]{32}\Z/i
  }
  attr_accessor :filename
  
  def initialize(filename)
    self.filename = filename.gsub(/\.\w+\Z/i,'') #we don't care about the extension
  end
  
  def possible_sources
    FILENAME_PATTERNS.select do |source,pattern|
      self.filename =~ pattern
    end.keys
  end
  
end
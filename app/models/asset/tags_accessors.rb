class Asset
  module TagsAccessors
    def tag_titles
      self.tags.map(&:title).join(' ')
    end
    
    def tag_titles=(new_titles)
      self.tags = new_titles.split(' ').map do |tag_title|
        self.tags.find_or_initialize_by(:title => tag_title)
      end
    end
  end
end
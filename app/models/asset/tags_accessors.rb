class Asset
  module TagsAccessors
    def tag_titles
      self.tags.map(&:title).join(' ')
    end
    
    def tag_titles=(new_titles)
      #FIXME?: I think the accessor should be atomic, nothing changes until .save is called.
      #Right now the array gets committed as soon as it changes here.
      #OPTIMIZE: Could knock this down to 2+n queries (n = new tags) by getting do an IN
      #search for all titles, then seeing what tags we didn't get (and thus need to create)
      self.tag_ids = new_titles.split(' ').map do |tag_title|
        tag_title = Tag.normalize_title_string(tag_title)
        Tag.find_or_create_by(:title => tag_title).id
      end
    end
  end
end
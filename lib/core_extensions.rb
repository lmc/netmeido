class Array
  def to_mongo_ids
    map { |id| BSON::ObjectId.from_string(id) }
  end
end
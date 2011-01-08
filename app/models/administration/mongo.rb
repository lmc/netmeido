class Administration::Mongo
  attr_accessor :options, :connection, :query
  
  DATABASE_METHODS = {
    addUser: %w[username password],
    auth: %w[username password],
    cloneDatabase: %w[from_host],
    commandHelp: %w[command_name],
    copyDatabase: %w[from_db to_db from_host],
    createCollection: %w[name args_hash]
  }
  
  def initialize(init_options = {})
    self.options = {
      :query      => "db.getCollectionNames()",
      :connection => Asset.db
    }.merge(init_options)
    self.connection = self.options.delete(:connection)
    self.query      = self.options.delete(:query)
  end
  
  def execute(query = self.query)
    self.connection.eval(query)
  end
  
  def collections
    
  end
  
end
settings = YAML::load(File.open(Rails.root.join('config','mongoid.yml')))[Rails.env]

Mongoid.configure do |config|
  config.master = Mongo::Connection.new(
    settings['host'], settings['port'], :logger => Rails.logger
  ).db(settings['database'])
  config.master.authenticate(settings['user'], settings['password']) if settings['user']
end

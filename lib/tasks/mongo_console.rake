namespace :db do
  desc 'Open a MongoDB console with connection parameters for the current Rails.env'
  task :console => :environment do
    conn = Mongoid.master.connection
    opts = ''
    opts << ' --username ' << conn.username if conn.username rescue nil
    opts << ' --password ' << conn.password if conn.password rescue nil
    opts << ' --host ' << conn.host_to_try[0]
    opts << ' --port ' << conn.host_to_try[1].to_s
    system "mongo #{opts} #{Mongoid.master.name}"
  end
end
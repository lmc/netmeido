class TimeCapsuleInterface
  module Archiving
    
    def self.included(base)
      base.send(:extend,ClassMethods)
    end
    
    module ClassMethods
      
      def archive_fields
        %w(bytes_in_dx bytes_out_dx errors_in_dx errors_out_dx)
      end
      
      def archive_periods
        { "5 minutes" => 5.minutes }
      end
      
      def archive!
        from_time = last_archive_time || Time.local(2011,1,1)
        to_time = Time.now
        
        archive_period(from_time,to_time)
      end
      
      def archive_period(from_time,to_time)
        archive_period = "5 minutes"
        archive_seconds = archive_periods[archive_period]
        query = self.where(:created_at.gt => from_time, :created_at.lt => to_time).descending(:created_at)
        
        #group into 5 minute chunks
        grouped = query.all.group_by { |tci| tci.created_at.to_i / archive_seconds } #TODO: mapreduce
        grouped.values.each do |group|
          start_of_period = group[-1].created_at
          archive = {} #archive[interface][field] = [most_recent_value...oldest_value]
          
          group.group_by(&:interface).each_pair do |interface,tcis|
            
            archive[interface] ||= {}
            archive_fields.each do |field|
              
              archive[interface][field] ||= []
              tcis.each do |tci|
                archive[interface][field] << tci.send(field)
              end
              
              
            end
          end
          
          archive.each_pair do |interface,interface_values|
            params = {:period_span => archive_period, :period_start => start_of_period, :interface => interface}
            interface_values.each_pair do |field,field_values|
              params[field] = field_values.sum / field_values.size rescue 0
            end
            TimeCapsuleInterface::Archive.create(params)
          end
          
        end
      end
      
      def last_archive_time
        TimeCapsuleInterface::Archive.descending(:archive_created_at).last.archive_created_at rescue nil
      end
      
    end
    
  end
end
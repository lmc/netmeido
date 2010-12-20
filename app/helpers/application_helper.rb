module ApplicationHelper
  def html5_time(datetime,format,options = {})
    options.reverse_merge!(
      :time_zone => Time.zone,
      :if_nil    => '',
      :pub_date  => false
    )
    
    format  = format.is_a?(Symbol) ? Date::DATE_FORMATS[format] : format
    display = datetime ? datetime.strftime(format) : options[:if_nil]
    attributes = {
      'datetime'       => (datetime ? datetime.to_s(:rfc822) : nil),
      'data-time-zone' => options[:time_zone].tzinfo.identifier,
      'data-format'    => format
    }
    
    content_tag(:time,attributes) { display }
  end
end

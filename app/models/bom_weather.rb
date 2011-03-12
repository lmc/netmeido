class BomWeather
  include WebScraper
  
  TIMEOUT = 10.0
  FORECAST_URL = "http://www.bom.gov.au/vic/forecasts/melbourne.shtml"
  DAYS_REGEX = /Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday/
  
  attr_accessor :raw_forecast_data, :forecast_error, :forecast_days
  
  def initialize
    
  end
  
  def get_forecast!
    begin
      Timeout.timeout(TIMEOUT) do
        client = self.class.web_client
        client.get(FORECAST_URL) do |page|
          self.forecast_error = nil
          parse_forecast(page)
        end
      end
    rescue Timeout::Error
      self.forecast_error = "Timeout::Error"
    end
    forecast_success?
  end
  
  def forecast_success?
    !self.forecast_error
  end
  
  
  protected
  
  def parse_forecast(page)
    self.raw_forecast_data = page.body
    self.forecast_days = {}
    page.search('div.day').each do |day|
      day_name = day.search('h2').inner_text.scan(DAYS_REGEX).first
      self.forecast_days[day_name] = {}
      self.forecast_days[day_name][:min]     = day.search('em.min').inner_text
      self.forecast_days[day_name][:max]     = day.search('em.max').inner_text
      self.forecast_days[day_name][:summary] = day.search('dd.summary').inner_text
      self.forecast_days[day_name][:full]    = day.search('h3 + p').inner_text
      
      alerts = day.search('p.alert')
      if alerts.size > 0
        self.forecast_days[day_name][:alerts] = alerts.map(&:inner_text)
      end
    end
  end
  
end
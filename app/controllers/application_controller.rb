class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  protect_from_forgery
  
  before_filter :set_time_zone
  
  
  private
  
  def set_time_zone
    Time.zone = "Melbourne"
  end
  
end

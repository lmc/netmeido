class TimeCapsuleInterfacesController < ApplicationController
  
  def index
    @search_options = TimeCapsuleInterface::SearchOptions.new(params[:search_options] || {})
    @data = TimeCapsuleInterface.search(@search_options)
  end
  
end
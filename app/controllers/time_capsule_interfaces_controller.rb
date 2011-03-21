class TimeCapsuleInterfacesController < ApplicationController
  
  def index
    @search_options = TimeCapsuleInterface::SearchOptions.new(params[:search_options] || {})
    @data = TimeCapsuleInterface.search(@search_options)
    
    @archive_search_options = TimeCapsuleInterface::ArchiveSearchOptions.new(params[:archive_search_options] || {})
    @archive_data = TimeCapsuleInterface::Archive.search(@archive_search_options)
    @archive_data.first
  end
  
end
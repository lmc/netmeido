class TimeCapsuleInterfacesController < ApplicationController
  respond_to :html, :json
  
  def index
    @search_options = TimeCapsuleInterface::SearchOptions.new(params[:search_options] || {})
    @data = TimeCapsuleInterface.search(@search_options)
    
    @archive_search_options = TimeCapsuleInterface::ArchiveSearchOptions.new(params[:archive_search_options] || {})
    @archive_data = TimeCapsuleInterface::Archive.search(@archive_search_options)
    
    respond_to do |format|
      format.html
      format.json { render :json => {
        :data => TimeCapsuleInterface.to_json_flot(@data), 
        :archive_data => TimeCapsuleInterface::Archive.to_json_flot(@archive_data)
      } }
    end
  end
  
end
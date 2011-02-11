class AssetsController < ApplicationController
  inherit_resources
  respond_to :html, :json
  
  new! do |success|
    @assets_multi_options = AssetMultiOptions.new({})
  end
  
  create! do |success,failure|
    success.html { redirect_to asset_url(@asset) }
  end
  
  
  private
  
  def collection
    @assets ||= get_collection
  end
  
  def get_collection
    collection = end_of_association_chain
    if params[:ids]
      collection = collection.where(:_id.in => params[:ids].split(',').to_mongo_ids)
    end
    collection.all
  end
  
end
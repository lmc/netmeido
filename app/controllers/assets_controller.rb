class AssetsController < ApplicationController
  inherit_resources
  respond_to :html, :json
  
  create! do |success,failure|
    success.html { redirect_to asset_url(@asset) }
  end
  
end
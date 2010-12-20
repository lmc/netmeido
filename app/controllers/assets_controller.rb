class AssetsController < ApplicationController
  inherit_resources
  create! do |success,failure|
    success.html { redirect_to asset_url(@asset) }
  end
end
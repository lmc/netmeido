class Administration::MongosController < ApplicationController
  before_filter :resource, :only => :show
  
  def show
    @query = @mongo.query
    @result = @mongo.execute
  end
  
  
  protected
  
  def resource
    @mongo ||= Administration::Mongo.new(params[:mongo] || {})
    @mongo
  end
  
end
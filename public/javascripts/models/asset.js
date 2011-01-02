var Asset = SuperModel.setup("Asset");
Asset.extend(BaseModelClassMethods);
Asset.include(BaseModelInstanceMethods);
Asset.include({
  
});












/*
var Asset = function(attributes){
  this.attributes = attributes;
  this.id = this.attributes._id;
  
  this.dom_id = function(){
    return "asset_"+this.id;
  };
  
  this.url = function(){
    return "/assets/"+this.id;
  };
  
  this.update_attributes = function(attributes){
    for(var key in attributes){
      this.attributes[key] = attributes[key];
    }
  };
  
  return this;
};
*/
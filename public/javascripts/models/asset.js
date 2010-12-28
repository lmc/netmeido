var Asset = function(attributes){
  this.attributes = attributes;
  this.id = this.attributes._id;
  
  this.url = function(){
    return "/assets/"+this.id;
  };
  
  return this;
};

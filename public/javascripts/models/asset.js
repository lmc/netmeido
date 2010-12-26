var Asset = function(){};
//Asset.prototype = new BaseModel();
Asset.prototype.constructor = function(id,attributes){
  this.id = id;
  this.attributes = attributes;
};

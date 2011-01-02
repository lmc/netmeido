var BaseModelClassMethods = {
  init: function(id,attributes,element){
    var instance = new this(attributes);
    instance.id = id;
    return instance;
  }
};

var BaseModelInstanceMethods = {
  single: function(){
    return this._class.className.toLowerCase();
  },
  plural: function(){
    return this.single() + 's'; //FIXME: Haha yeah good plural-ing there mister
  },
  
  dom_id: function(){
    return this.single() + "_" + this.id;
  },
  
  url: function(){
    return "/" + this.plural() + "/" + this.id;
  },
  
  onjuggernautpush: function(data){
    var event_name = data.event_name;
  }
};
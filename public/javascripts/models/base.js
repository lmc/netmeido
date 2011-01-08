var BaseModelClassMethods = {
  init: function(id,attributes){
    var instance = new this(attributes);
    instance.id = id;
    instance.init_juggernaut();
    return instance;
  },
  init_json: function(attributes){
    var id = attributes._id;
    delete attributes._id;
    return this.init(id,attributes);
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
  
  init_juggernaut: function(){
    window.juggernaut_client.subscribe(this.url(),$.proxy(this.onjuggernautpush,this));
  },
  
  onjuggernautpush: function(data){
    var event_name = 'push:'+data.event_name;
    this._class.trigger(event_name,data);
  }
};
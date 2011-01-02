$.fn.model_instance = function(){
  var klass_id = this.attr('id').match(/(\w+)_(\w+)/);
  var klass = klass_id[1].replace(/^(.)/,function(str){ return str.toUpperCase(); });
  var id = klass_id[2], attributes = this.data('attributes');
  delete attributes._id;
  var instance = window[klass].init(id,attributes);
  instance.element = this;
  return instance;
};
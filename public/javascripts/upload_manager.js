$.fn.upload_manager = function(options){
  var defaults = {
    
  };
  
  var form   = this;
  var config = $.extend(defaults,options);
  
  var field_file  = form.find('input[type="file"]');
  var field_url   = form.find('input[name$="_url]"]');
  var drop_target = form.find('.html5_upload_area');
  
  var queue = []; //[source_name,file object]
  
  var filedrop = drop_target.filedrop({
    url: '/assets',
    paramname: 'asset[file]',
    data: {
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    },
    drop: function(event){
      //add event.dataTransfer.files to queue
    },
    dragOver: function(event){
      $(event.target).addClass('drag_over');
    },
    dragLeave: function(event){
      $(event.target).removeClass('drag_over');
    }
  });
  
  form.submit(function(event){
    alert(filedrop.files_count());
    return false;
  });
  
  return this;
};
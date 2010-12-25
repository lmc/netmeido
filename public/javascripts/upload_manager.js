$.fn.upload_manager = function(options){
  var defaults = {
    queue_item_template: '<li>${file.name}</li>'
  };
  
  var form   = this;
  var config = $.extend(defaults,options);
  
  var field_file  = form.find('input[type="file"]');
  var field_url   = form.find('input[name$="_url]"]');
  var drop_target = form.find('.html5_upload_area');
  
  var queue = []; //[source_name,file object]
  var queue_list = form.find('fieldset.queue ol');
  
  var queue_item_template = $.template('queue_item_template',config.queue_item_template);
  
  var filedrop = drop_target.filedrop({
    url: '/assets',
    paramname: 'asset[file]',
    data: {
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    },
    drop: function(event){
      //add  to queue
      $.each(event.dataTransfer.files,function(_i,file){
        queue.push(file);
        $.tmpl("queue_item_template",{file: file}).appendTo(queue_list);
      });
    },
    dragOver: function(event){
      $(event.target).addClass('drag_over');
    },
    dragLeave: function(event){
      $(event.target).removeClass('drag_over');
    },
    uploadStarted: function(_index,file,_total){
      queue_list.html(file.name+" is started!");      
    },
    progressUpdated: function(_index,file,progress){
      queue_list.html(file.name+" is "+progress);
    }
  });
  
  form.submit(function(event){
    alert(filedrop.files_count());
    $.each(queue,function(_i,file){
      filedrop.upload_file(file);
    });
    return false;
  });
  
  return this;
};
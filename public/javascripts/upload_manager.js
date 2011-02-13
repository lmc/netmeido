$.fn.upload_manager = function(options){
  var defaults = {
    queue_item_template: $('script#upload_manager_queue_item')
  };
  
  var form   = this;
  var config = $.extend(defaults,options);
  
  var field_file  = form.find('input[type="file"]');
  var field_url   = form.find('input[name$="_url]"]');
  var drop_target = form.find('.html5_upload_area');
  
  var queue = []; //[source_name,file object]
  var queue_items = []; //html elements for each queue item
  var queue_list = form.find('fieldset.queue ol');
  
  var queue_item_template = $.template('queue_item_template',config.queue_item_template);
  
  var next_file_index = 0;
  var statuses = ['pending','connecting','started','processing','finished'];
  var statuses_classes = statuses.join(' ');
  
  var max_preview_filesize = 512 * 1024; //anything larger than 512kb makes firefox run out of script stack space
  var preview_image = 'default.png';
  
  var uploaded_ids = [];
  
  var file_remote_options = {
    url: '/assets.json',
    paramname: 'asset[remote_file_url]',
    accept_keycodes: [13]
  };
  
  var filedrop = drop_target.filedrop({
    url: '/assets.json',
    paramname: 'asset[file]',
    data: {
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    },
    maxfilesize: 10,
    drop: function(event){
      $.each(event.dataTransfer.files,function(_i,file){
        create_queue_item_for(file);
      });
    },
    dragOver: function(event){
      $(event.target).addClass('drag_over');
    },
    dragLeave: function(event){
      $(event.target).removeClass('drag_over');
    },
    uploadStarted: function(_index,file,_total){
      queue_item_for(file).removeClass(statuses_classes).addClass("started").
        find('.status').html("Started");
    },
    progressUpdated: function(_index,file,progress){
      var progress_label = progress + '%';
      queue_item_for(file).find('.progress_label').html(progress_label);
      queue_item_for(file).find('.progress_bar .inner').css({width: progress+'%'});
    },
    uploadFinished: function(_index,file,json,time_taken){
      finish_upload_for(file,json);
      next_file_index++;
      if(next_file_index < queue.length){
        start_upload_for(next_file_index);
      }else{
        window.location = "/assets?ids="+uploaded_ids.join(',');
      }
    }
  });
  
  var start_upload_for = function(queue_offset){
    var file = queue[queue_offset];
    if(file.type == 'application/x-remote-file'){
      var params = file_remote_options.paramname+'='+file.remote_url;
      $.ajax({type: 'POST', url: file_remote_options.url, data: params,
        success: function(json){ finish_upload_for(file,json); }
      });
    }else{
      filedrop.upload_file(queue[queue_offset]);
    }
  };
  
  var finish_upload_for = function(file,json){
    var asset = Asset.init_json(json);
    
    queue_item_for(file).removeClass(statuses_classes).addClass("finished");
    queue_item_for(file).find('.status').html("Completed");
    queue_item_for(file).find('.url').attr('href',asset.url());
    
    uploaded_ids.push(asset.id);
  };
  
  var create_queue_item_for = function(file){
    var preview_url = file.size < max_preview_filesize && file.getAsDataURL ? file.getAsDataURL() : preview_image;
    if(!preview_url || !preview_url.length) preview_url = preview_image;
    var queue_item = $.tmpl("queue_item_template",{file: file,preview_url: preview_url});
    queue_item.addClass('pending');
    queue.push(file);
    queue_items.push(queue_item);
    queue_item.appendTo(queue_list);
  };
  
  var queue_index_for = function(file_object){
    return queue.indexOf(file_object);
  };
  var queue_item_for = function(file_object){
    return queue_items[queue_index_for(file_object)];
  };
  
  field_url.keydown(function(event){
    if($.inArray(event.which,file_remote_options.accept_keycodes) != -1){
      var urls = [field_url.val()]; //TODO: handle multiple urls entered at once
      $.each(urls,function(_i,url){
        create_queue_item_for(new RemoteFile(url));
      });
      field_url.val('');
      return false;
    }
  });
  
  form.submit(function(event){
    next_file_index = 0;
    start_upload_for(next_file_index);
    return false;
  });
  
  return this;
};

var RemoteFile = function(remote_url){
  this.remote_url = remote_url;
  this.name = remote_url.split('/').pop();
  this.type = 'application/x-remote-file';
};
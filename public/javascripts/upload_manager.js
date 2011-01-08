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
  var statuses = ['pending','started','processing','finished'];
  var statuses_classes = statuses.join(' ');
  
  var max_preview_filesize = 512 * 1024; //anything larger than 512kb makes firefox run out of script stack space
  var preview_image = '';
  
  var uploaded_ids = [];
  
  var filedrop = drop_target.filedrop({
    url: '/assets.json',
    paramname: 'asset[file]',
    data: {
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    },
    maxfilesize: 10,
    drop: function(event){
      $.each(event.dataTransfer.files,function(_i,file){
        var preview_url = file.size < max_preview_filesize ? file.getAsDataURL() : preview_image;
        var queue_item = $.tmpl("queue_item_template",{file: file,preview_url: preview_url});
        queue.push(file);
        queue_items.push(queue_item);
        queue_item.appendTo(queue_list);
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
      queue_item_for(file).find('.progress').html(progress);
    },
    uploadFinished: function(_index,file,json,time_taken){
      var asset = Asset.init_json(json);
      
      queue_item_for(file).removeClass(statuses_classes).addClass("finished");
      queue_item_for(file).find('.status').html("Completed in "+time_taken);
      queue_item_for(file).find('.url').attr('href',asset.url());
      
      uploaded_ids.push(asset.id);
      
      next_file_index++;
      if(next_file_index < queue.length){
        filedrop.upload_file(queue[next_file_index]);
      }else{
        window.location ="/assets?ids="+uploaded_ids.join(',');
      }
    }
  });
  
  var queue_index_for = function(file_object){
    return queue.indexOf(file_object);
  };
  var queue_item_for = function(file_object){
    return queue_items[queue_index_for(file_object)];
  };
  
  form.submit(function(event){
    next_file_index = 0;
    filedrop.upload_file(queue[0]);
    return false;
  });
  
  return this;
};
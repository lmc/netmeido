$.fn.tags_editor = function(options){
  var delete_btn = '<a href="#" class="icon_button delete">Delete</a>';
  var defaults = {
    tags_list_item_template: '<li data-tag="${tag}">'+delete_btn+'${tag}</li>'
  };
  
  var textarea  = this;
  var config    = $.extend(defaults,options);
  
  var fieldset  = $(this).parents('fieldset');
  var related   = fieldset.find('li.related_tags ul');
  //var tags_list = fieldset.find('li.all_tags     ul');
  
  fieldset.find('ol').hide();
  fieldset.append('<ol class="tags_list"></ol>');
  var tags_list = fieldset.find('ol.tags_list');
  
  var tags_list_item_template = $.template('tags_list_item_template',config.tags_list_item_template);
  
  fieldset.addClass('tags_editor');
  
  var textarea_update = function(event){
    tags_list_truncate();
    $.each(all_tags(),function(_i,tag){
      tags_list_add(tag);
    });
  };
  
  var all_tags = function(){
    return textarea.val().split(' ');
  };
  
  var current_tag = function(){
    
  };
  
  var tags_list_truncate = function(){
    $('li',tags_list).remove();
  };
  
  var tags_list_add = function(tag_title){
    $.tmpl("tags_list_item_template",{tag: tag_title}).appendTo(tags_list);
  };
  
  
  textarea.change(textarea_update);
  textarea.keyup(textarea_update);
  textarea_update();
};
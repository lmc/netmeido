$(document).ready(function(){
  
  if($('form#new_asset').length){
    $('form#new_asset').upload_manager({
      
    });
  }
  
  $('#asset_tag_titles').tags_editor({
    
  });
  
  if($('li.asset ul.actions li.edit_tags a').length){
    var template = $.template('asset_edit_tags_template',$('script#asset_tags_editor'));
    $('li.asset ul.actions li.edit_tags a').live('click',function(event){
      var asset_element = $(event.target).parents('li.asset');
      //$.tmpl('asset_edit_tags_template',)
      return false;
    });
  }
});


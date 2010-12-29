$(document).ready(function(){
  
  if($('form#new_asset').length){
    $('form#new_asset').upload_manager({
      
    });
  }
  
  if($('#asset_tag_titles').length){
    $('#asset_tag_titles').tags_editor({
    
    });
  }
  
  if($('li.asset ul.actions li.edit_tags a').length){
    var template = $.template('asset_tags_editor_template',$('script#asset_tags_editor'));
    $('li.asset ul.actions li.edit_tags a').live('click',function(event){
      var asset_element = $(event.target).parents('li.asset');
      var asset = new Asset(asset_element.data('attributes'));
      $.tmpl("asset_tags_editor_template",{asset: asset}).appendTo(asset_element);;
      var tags_editor = asset_element.find('textarea#asset_tag_titles');
      tags_editor.tags_editor({});
      
      return false;
    });
  }
});


var juggernaut_client;

function dialog_options(options){
  if(!options)
    options = {};
  return $.extend({},{
    modal: true,
    width: $('body').width() * 0.8
  },options);
}

$(document).ready(function(){
  var juggernaut_client = new Juggernaut;
  juggernaut_client.connect();
  window.juggernaut_client = juggernaut_client;
  
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
      var asset = asset_element.model_instance();
      
      var tags_editor_html = $.tmpl("asset_tags_editor_template",{asset: asset});
      tags_editor_html.dialog(dialog_options({}));
      var form = tags_editor_html; //assumes the form is the root of the template
      
      var tags_editor = asset_element.find('textarea#asset_tag_titles');
      tags_editor.val(asset.tag_titles);
      tags_editor.tags_editor({});
      
      form.submit(function(event){
        var data = form.serialize();
        $.ajax({
          url: form.attr('action'),
          type: form.attr('method'),
          data: data,
          complete: function(request,status){
          },
          success: function(data,status,request){
            console.log(data);
          },
          error: function(request,status,error){
            
          }
        });
        return false;
      });
      
      
      return false;
    });
  }
});


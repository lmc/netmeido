$(document).ready(function(){
  $('.html5_upload_area').filedrop({
    url: '/assets',
    paramname: 'asset[file]',
    data: {
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    },
    dragOver: function(event){
      $(event.target).addClass('drag_over');
    },
    dragLeave: function(event){
      $(event.target).removeClass('drag_over');
    }
  });  
});


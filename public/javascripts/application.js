$(document).ready(function(){
  $.plot($('#time_capsule_interfaces_graph'),format_flot_data_datetimes(time_capsule_interfaces_data),{
    
  });
});

function format_flot_data_datetimes(data){
  $.each(data,function(index,series){
    $.each(series.data,function(index,datum){
      datum[0] = new Date(datum[0] * 1000);
    })
  });
  return data;
}
$(document).ready(function(){
  $.plot($('#time_capsule_interfaces_graph'),format_flot_data_datetimes(time_capsule_interfaces_data),{

    xaxis: {
      mode: "time",
      timeformat: "%H:%M:%S",
      tickSize: [1, "minute"]
    },
    
    yaxis: {
      tickSize: 102.4*1024,
      tickFormatter: function(value,axis){
        return bytesToSize(value,2);
      }
    }
    
  });
});


function format_flot_data_datetimes(data){
  var timezone_offset_seconds = ((new Date).getTimezoneOffset() * 60) * -1;
  $.each(data,function(index,series){
    $.each(series.data,function(index,datum){
      datum[0] = new Date( (datum[0] + timezone_offset_seconds) * 1000 );
    })
  });
  return data;
}



//http://codeaid.net/javascript/convert-size-in-bytes-to-human-readable-format-%28javascript%29
/**
 * Convert number of bytes into human readable format
 *
 * @param integer bytes     Number of bytes to convert
 * @param integer precision Number of digits after the decimal separator
 * @return string
 */
function bytesToSize(bytes, precision)
{	
	var kilobyte = 1024;
	var megabyte = kilobyte * 1024;
	var gigabyte = megabyte * 1024;
	var terabyte = gigabyte * 1024;
	
	if ((bytes >= 0) && (bytes < kilobyte)) {
		return bytes + ' B';

	} else if ((bytes >= kilobyte) && (bytes < megabyte)) {
		return (bytes / kilobyte).toFixed(precision) + ' KB/s';

	} else if ((bytes >= megabyte) && (bytes < gigabyte)) {
		return (bytes / megabyte).toFixed(precision) + ' MB/s';

	} else if ((bytes >= gigabyte) && (bytes < terabyte)) {
		return (bytes / gigabyte).toFixed(precision) + ' GB/s';

	} else if (bytes >= terabyte) {
		return (bytes / terabyte).toFixed(precision) + ' TB/s';

	} else {
		return bytes + ' B/s';
	}
}
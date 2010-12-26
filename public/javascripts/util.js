//TODO: URL builder like $.url({path: "/assets/:id", id: "123", query: {herp: "derp"}})
$.fn.url = function(args){
  var defaults = {
    protocol:     window.location.protocol,
    use_protocol: true, //Only considered if use_host is also true, then true=http://host,false=//host
    host:         window.location.hostname,
    use_host:     false,
    port:         window.location.port,
    path:         window.location.pathname,
    query:        window.location.search,
    hash:         window.location.hash
  };
  
};
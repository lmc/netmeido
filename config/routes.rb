Netmeido::Application.routes.draw do
  
  resources :time_capsule_interfaces, :only => :index
  
end

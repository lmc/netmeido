#Fix because no-one can get two yaml parsers working together with 1.9.2
require 'yaml'
YAML::ENGINE.yamler= 'syck' 

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Netmeido::Application.initialize!

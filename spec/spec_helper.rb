#!/usr/bin/env ruby
# vim:set fileencoding=utf-8 filetype=ruby

require 'rubygems'
if File.file?(config_environment_rb = File.expand_path("../../../../config/environment.rb", File.dirname(__FILE__)))
  require config_environment_rb
else
  require 'active_support'
  require 'action_controller'
end

$LOAD_PATH.unshift File.expand_path("../../../../", File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))


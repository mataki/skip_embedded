#!/usr/bin/env ruby
# vim:set fileencoding=utf-8 filetype=ruby

require 'rubygems'

gem 'rails', '2.1.2'
require 'active_support'
require 'action_controller'

$LOAD_PATH.unshift File.expand_path("../../../../", File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

RAILS_ENV="test"
require 'skip_collabo/initial_settings'
SkipEmbedded::InitialSettings.config = File.expand_path("initial_settings.yml", File.dirname(__FILE__))


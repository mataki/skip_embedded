#!/bin/sh -x

APP_NAME=${1}
rails _2.1.2_ ${APP_NAME}

cd ${APP_NAME}

cat <<GITIGNORE > .gitignore
config/database.yml
config/initial_settings.yml
log/*
db/*.sqlite3
db/schema.rb
tmp/*
GITIGNORE

ruby script/generate rspec
ruby script/generate cucumber

ruby script/generate relying_party Sessions name:string display_name:string
cat <<PATCH | patch -p2
diff --git a/skip-sample/app/controllers/application.rb b/skip-sample/app/controllers/application.rb
index 1d54efd..fbd1cf2 100644
--- a/skip-sample/app/controllers/application.rb
+++ b/skip-sample/app/controllers/application.rb
@@ -4,6 +4,8 @@
 class ApplicationController < ActionController::Base
   helper :all # include all helpers, all the time
   include Repim::Application
+  layout "skip_embedded"
+  init_gettext("skip-todo") if defined?(GetText)
 
   # See ActionController::RequestForgeryProtection for details
   # Uncomment the :secret if you're not using the cookie session store
diff --git a/skip-sample/app/controllers/sessions_controller.rb b/skip-sample/app/controllers/sessions_controller.rb
index e7ebe5a..a031e88 100644
--- a/skip-sample/app/controllers/sessions_controller.rb
+++ b/skip-sample/app/controllers/sessions_controller.rb
@@ -1,4 +1,7 @@
 class SessionsController < ApplicationController
   include OpenIdAuthentication
   include Repim::RelyingParty
+
+  use_attribute_exchange(["http://axschema.org", "http://schema.openid.net"],
+                          :display_name => "/namePerson", :name => "/namePerson/friendly" )
 end
diff --git a/skip-sample/config/environment.rb b/skip-sample/config/environment.rb
index a0fb06a..bda6d11 100644
--- a/skip-sample/config/environment.rb
+++ b/skip-sample/config/environment.rb
@@ -25,6 +25,8 @@ Rails::Initializer.run do |config|
   # config.gem "bj"
   # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
   # config.gem "aws-s3", :lib => "aws/s3"
+  config.gem 'moro-repim', :lib => 'repim', :source => 'http://gems.github.com/'
+  config.gem 'openskip-skip_embedded', :lib => 'skip_embedded', :source => 'http://gems.github.com/'
 
   # Only load the plugins named here, in the order given. By default, all plugins 
   # in vendor/plugins are loaded in alphabetical order.
PATCH

ruby script/generate skip_embedded
rake skip_embedded:thirdparty
rm app/views/layouts/sessions.html.erb public/index.html

cd -


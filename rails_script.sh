SITE_NAME="atest_nico"
HOME_DIR="$(pwd)"
rails new "$SITE_NAME"
cd "$SITE_NAME"
bundle add devise  
rails g devise:install  
#
#  1. Ensure you have defined default url options in your environments files. Here
#     is an example of default_url_options appropriate for a development environment
#     in config/environments/development.rb:
#
#       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
#
#     In production, :host should be set to the actual host of your application.
#
#     * Required for all applications. *

# Ajoute au dessus de yield
awk '/yield/ { print "    <p class=\"notice\"><%= notice %></p>\n    <p class=\"alert\"><%= alert %></p>"  } 1' app/views/layouts/application.html.erb > /tmp/a
mv /tmp/a app/views/layouts/application.html.erb
#geneRATE HOME PAGE
rails generate controller Pages home
cp $HOME_DIR/homepage_skeleton.erb app/views/pages/home.html.erb
awk '/home/ { $0 = "  root \047pages#home\047" } 1' config/routes.rb > temp && mv temp config/routes.rb
rails g controller users admins
rails g devise user
rails g devise admin
rails g devise:controllers users
rails g devise:controllers admins
awk '/:admins/ { gsub(/$/, ", controllers: {\n    sessions: \047admins/sessions\047,\n    registrations: \047admins/registrations\047\n  }"); } 1' config/routes.rb > /tmp/a
awk '/:users/ { gsub(/$/, ", controllers: {\n    sessions: \047users/sessions\047,\n    registrations: \047users/registrations\047\n  }"); } 1' /tmp/a > config/routes.rb
rails g devise:views
rails g devise:views users
rails g devise:views admins
rails db:migrate



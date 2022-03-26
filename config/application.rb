require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module DgmsNewsApi
  class Application < Rails::Application
    initializer(:remove_activestorage_routes, after: :add_routing_paths) do |app|
      app.routes_reloader.paths.delete_if { |path| path =~ /activestorage|actionmailbox/ }
    end
    config.load_defaults 7.0
    config.api_only = true
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_namespace_key'
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.skip_routes true
      generate.helper_specs false
      generate.routing_specs false
      generate.controller_specs false
      generate.request_specs false
    end
  end
end

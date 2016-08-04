Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and caching is turned on.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = {
    host: Settings.app_host,
    script_name: Settings.relative_url_root,
    protocol: Settings.app_scheme.tr(':/', '')
  }
  config.action_mailer.delivery_method =
    Settings.action_mailer.delivery_method.to_sym
  config.action_mailer.smtp_settings =
    Settings.action_mailer.smtp_settings.to_h

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Use the relative URL to build the paths for assets, too, please...
  config.action_controller.relative_url_root = Settings.relative_url_root

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Configure cache store.
  # YAML Hash values (see memory_store example in settings.yml) get turned into
  # Config::Options objects, but we need them as hashes.
  cache_settings = Settings.cache.to_hash
  config.cache_store = cache_settings[:store].to_sym, *cache_settings[:opts]

  # Initialize the Google Analytics tracker
  # GoogleAnaltyics is defined in the google-analtyics-rails gem
  GoogleAnalytics.tracker = Settings.googleanalytics.tracker
end

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

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load


  # Use the relative URL to build the paths for assets, too, please...
  config.action_controller.relative_url_root = Settings.relative_url_root

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Configure cache store.
  # YAML Hash values (see memory_store example in settings.yml) get turned into
  # Config::Options objects, but we need them as hashes.
  # cache_settings = Settings.cache.to_hash
  # config.cache_store = cache_settings[:store].to_sym, *cache_settings[:opts]

end

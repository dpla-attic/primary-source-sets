# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
Rails.application.config.assets.precompile += %w( upload.js )
Rails.application.config.assets.precompile += %w( docupload.js )
Rails.application.config.assets.precompile += %w( imgupload.js )
Rails.application.config.assets.precompile += %w( form.js )

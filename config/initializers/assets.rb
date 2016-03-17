# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
Rails.application.config.assets.precompile += %w( avupload.js )
Rails.application.config.assets.precompile += %w( carousel.js )
Rails.application.config.assets.precompile += %w( docupload.js )
Rails.application.config.assets.precompile += %w( imgupload.js )
Rails.application.config.assets.precompile += %w( form.js )
Rails.application.config.assets.precompile += %w( style.js )
Rails.application.config.assets.precompile += %w( openseadragon.js )
Rails.application.config.assets.precompile += %w( results-bar.js )
Rails.application.config.assets.precompile += %w( poster.js )
Rails.application.config.assets.precompile += %w( tag_sequence.js )

# Precompile assets from gems
Rails.application.config.assets.precompile += %w( dpla-colors.css dpla-fonts.css )
Rails.application.config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif *.ico )
Rails.application.config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif *.ico )
Rails.application.config.assets.precompile += %w( *.eot *.svg *.ttf *.woff )

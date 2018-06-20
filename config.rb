# --------------------------------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------------------------------

helpers do
  # Helpers are defined in and can be added to `helpers/custom_helpers.rb`.
  # In case you require helpers within `config.rb`, they can be added here.
  def photoessay_link(photoessay)
    "/photoessays/#{photoessay.url}"
  end
end

require_relative './lib/reading_time'
activate :reading_time

# --------------------------------------------------------------------------------------------------
# Blog
# --------------------------------------------------------------------------------------------------

activate :blog do |blog|
  blog.prefix = "blog"
  blog.layout = "blog"
  blog.calendar_template = "/blog/calendar.html"
  blog.tag_template = "/blog/tag.html"
  blog.summary_separator = /READMORE/
end

# --------------------------------------------------------------------------------------------------
# Extensions
# --------------------------------------------------------------------------------------------------

# Use LiveReload
activate :livereload

# Use Search Engine Sitemap
set :url_root, data.config.site.root_url
activate :search_engine_sitemap

# User Bower to manage vendor scripts
activate :bower

# Automatic image dimensions on image_tag helper (only works with local images)
# activate :automatic_image_sizes

# Split up each required asset into its own script/style tag instead of combining them
set :debug_assets, true

# --------------------------------------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------------------------------------

set :css_dir,     'stylesheets'
set :fonts_dir,   'fonts'
set :images_dir,  'images'
set :js_dir,      'javascripts'

# Pretty URLs - See https://middlemanapp.com/advanced/pretty_urls/
activate :directory_indexes

# --------------------------------------------------------------------------------------------------
# Build configuration
# --------------------------------------------------------------------------------------------------
# Run build cleaner
# require_relative "./lib/build_cleaner"

configure :build do

  # Exclude any vendor components (bower or custom builds) in the build
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/vendor/*'

  activate :gzip

  # Minify CSS
  activate :minify_css

  # Minify Javascript
  activate :minify_javascript

  # Minify HTML
  activate :minify_html, remove_http_protocol: false,
                         remove_https_protocol: false,
                         remove_input_attributes: false,
                         remove_quotes: false

  # Compress images (default)
  require 'middleman-smusher'
  activate :smusher

  # Compress ALL images (advanced)
  # Before activating the below, follow setup instructions on https://github.com/toy/image_optim
  # activate :imageoptim do |options|
  #   options.pngout = false # set to true when pngout is also installed
  # end

  # Uniquely-named assets (cache buster)
  # Exception: svg & png in images folder because they need to be interchangeable by JS
  activate :asset_hash, ignore: [%r{(.*\.jpeg|.*\.jpg|.*\.png|.*\.svg)$}i]
end

# --------------------------------------------------------------------------------------------------
# Github Pages Deploy
# --------------------------------------------------------------------------------------------------

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end

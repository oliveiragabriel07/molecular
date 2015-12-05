require 'molecular/routes'
require 'mandrill-rails'
require 'jquery-rails'
require 'tinymce-rails'
require 'tinymce-rails-langs'

module Molecular
  class Engine < ::Rails::Engine
    isolate_namespace Molecular

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # config.assets.paths << Rails.root.join("lib", "assets")
    config.tinymce.install = :compile
  end
end

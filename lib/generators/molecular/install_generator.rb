require 'rails/generators/base'

module Molecular
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../templates", __FILE__)

    desc "Creates a molecular initializer at config/initializers"

    def copy_initializer
      template "molecular.rb", "config/initializers/molecular.rb"
    end
  end
end

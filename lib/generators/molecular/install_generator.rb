require 'rails/generators/base'

module Molecular
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../../../templates", __FILE__)

    desc "Creates a molecular initializer at config/initializers"

    def copy_initializer
      template "molecular.rb", "config/initializers/molecular.rb"
    end

    desc "add the migrations"

    def copy_migrations
        copy_migration "create_molecular_campaigns"
    end

    def self.next_migration_number(path)
      unless @prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end

    protected
      def copy_migration(filename)
        if self.class.migration_exists?("db/migrate", filename)
          say_status("skipped", "Migration #{filename}.rb already exists")
        else
          migration_template "migrations/#{filename}.rb", "db/migrate/#{filename}.rb"
        end
      end
  end
end

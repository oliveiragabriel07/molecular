require 'rails/generators/base'

module Molecular
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../../../templates", __FILE__)

    desc "Generates a molecular initializer at config/initializers." \
      "Generates a Molecular::Campaign model, copy migrations and add" \
      "molecular routes"

    def copy_initializer
      template "molecular.rb", "config/initializers/molecular.rb"
    end

    def copy_migrations
      copy_migration "create_molecular_campaigns"
      copy_migration "create_molecular_recipients"
      copy_migration "create_molecular_subscriptions"
      copy_migration "create_molecular_events"
    end

    def copy_campaign_decorator
      template "decorators/campaign_decorator.rb",
               "app/decorators/models/molecular/campaign_decorator.rb"
    end

    # def add_molecular_routes
    #   route "mount_molecular"
    # end

    def self.next_migration_number(number)
      if !@prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end

    protected
      def copy_migration(filename)
        migration_template "migrations/#{filename}.rb",
                           "db/migrate/#{filename}.rb"
      end
  end
end

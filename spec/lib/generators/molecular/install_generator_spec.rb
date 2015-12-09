require 'spec_helper'
require 'generator_spec'
require 'generators/molecular/install_generator'

module Molecular
  describe InstallGenerator do
    destination File.expand_path("../../../../tmp", __FILE__)

    before(:all) do
      prepare_destination
      run_generator
    end

    it "creates a molecular initializer" do
      assert_file "config/initializers/molecular.rb"
    end

    it "creates molecular campaign migration" do
      assert_migration "db/migrate/create_molecular_campaigns.rb"
    end

    it "creates molecular events migration" do
      assert_migration "db/migrate/create_molecular_events.rb"
    end

    it "creates molecular recipients migration" do
      assert_migration "db/migrate/create_molecular_recipients.rb"
    end

    it "creates molecular subscriptions migration" do
      assert_migration "db/migrate/create_molecular_subscriptions.rb"
    end

    it "creates molecular campaign decorator" do
      assert_file "app/decorators/models/molecular/campaign_decorator.rb"
    end
  end
end

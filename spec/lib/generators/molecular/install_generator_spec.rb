require 'spec_helper'
require 'generator_spec'
require 'generators/molecular/install_generator'

module Molecular
  describe InstallGenerator do
    destination File.expand_path("../../../../tmp", __FILE__)

    context 'creates' do
      before(:all) do
        prepare_destination
        run_generator
      end

      it "a molecular initializer" do
        assert_file "config/initializers/molecular.rb"
      end

      it "molecular campaign migration" do
        assert_migration "db/migrate/create_molecular_campaigns.rb"
      end

      it "molecular events migration" do
        assert_migration "db/migrate/create_molecular_events.rb"
      end

      it "molecular recipients migration" do
        assert_migration "db/migrate/create_molecular_recipients.rb"
      end

      it "molecular subscriptions migration" do
        assert_migration "db/migrate/create_molecular_subscriptions.rb"
      end

      it "molecular campaign decorator" do
        assert_file "app/decorators/models/molecular/campaign_decorator.rb"
      end
    end

    # it "skips existing migrations" do
    #   prepare_destination

    #   content = "content wont be changed"
    #   ts = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    #   migration = "db/migrate/#{ts}_create_molecular_subscriptions.rb"
    #   path = File.join(test_case.destination_root, migration)

    #   FileUtils.mkdir_p(File.dirname(path))
    #   File.open(path, "w+") { |f| f.write(content) }

    #   run_generator
    #   assert_file migration, content
    # end
  end
end

class AddCountersToMolecularSubscription < ActiveRecord::Migration
  def change
    add_column :molecular_subscriptions, :opens_count, :integer
    add_column :molecular_subscriptions, :clicks_count, :integer
  end
end

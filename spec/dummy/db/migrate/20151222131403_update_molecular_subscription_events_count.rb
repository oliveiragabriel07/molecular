class UpdateMolecularSubscriptionEventsCount < ActiveRecord::Migration
  def up
    Molecular::Subscription.find_each do |subscription|
      subscription.update(clicks_count: subscription.events.clicks.count)
      subscription.update(opens_count: subscription.events.opens.count)
    end
  end

  def down
  end
end

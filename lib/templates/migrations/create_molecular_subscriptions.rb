class CreateMolecularSubscriptions < ActiveRecord::Migration
  def change
    create_table :molecular_subscriptions do |t|
      t.references :campaign
      t.references :recipient
      t.integer :status, default: 0
      t.integer :opens_count
      t.integer :clicks_count

      t.timestamps null: false
    end
  end
end

class CreateMolecularLists < ActiveRecord::Migration
  def change
    create_table :molecular_lists do |t|
      t.references :campaign
      t.references :recipient
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end

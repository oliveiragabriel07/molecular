class CreateMolecularEvents < ActiveRecord::Migration
  def change
    create_table :molecular_events do |t|
      t.references :list, index: true, foreign_key: true
      t.string :label
      t.string :value

      t.timestamps null: false
    end
  end
end

class CreateMolecularCampaigns < ActiveRecord::Migration
  def change
    create_table :molecular_campaigns do |t|
      t.references :owner, polymorphic: true, index: true
      t.string :subject
      t.text :body
      t.string :recipients_query
      t.datetime :sent_at
      t.string :from
      t.string :from_name

      t.timestamps null: false
    end
  end
end

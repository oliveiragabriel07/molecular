class AddFromToMolecularCampaigns < ActiveRecord::Migration
  def change
    add_column :molecular_campaigns, :from, :string
    add_column :molecular_campaigns, :from_name, :string
  end
end

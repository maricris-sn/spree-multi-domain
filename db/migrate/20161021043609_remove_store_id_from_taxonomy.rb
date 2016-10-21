class RemoveStoreIdFromTaxonomy < ActiveRecord::Migration
  def change
  	remove_column :spree_taxonomies, :store_id, :integer
  end
end

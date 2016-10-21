class AddColorToStore < ActiveRecord::Migration
  def change
  	add_column :spree_stores, :color, :string
  end
end

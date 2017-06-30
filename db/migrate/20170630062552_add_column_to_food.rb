class AddColumnToFood < ActiveRecord::Migration
  def change
  	add_column :foods, :latitude, :float
  	add_column :foods, :longitude, :float
  	add_column :foods, :formatted_address, :string
  end
end

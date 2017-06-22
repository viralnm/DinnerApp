class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
    	t.string :name
    	t.references :user, index: true
    	t.references :restaurant, index: true
   	 t.string        :photo_file_name
     t.string        :photo_content_type
     t.string        :photo_file_size
     t.string        :photo_updated_at
     t.timestamps null: false
    end
  end
end

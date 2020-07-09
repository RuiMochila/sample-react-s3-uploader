class AddIndexToPicturesKey < ActiveRecord::Migration[6.0]
  def change
    remove_index :pictures, :key
    add_index :pictures, :key, unique: true
  end
end

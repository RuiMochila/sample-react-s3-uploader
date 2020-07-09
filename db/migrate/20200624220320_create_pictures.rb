class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.references :pictureable, polymorphic: true, index: { name: 'index_pictureable' }
      t.string :scope
      t.string :key
      t.string :url
      t.boolean :is_processed

      t.timestamps
    end
    add_index :pictures, [:pictureable_type, :pictureable_id, :scope], name: 'by_scoped_parent'
    add_index :pictures, :key
  end
end

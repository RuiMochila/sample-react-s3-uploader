class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :auth_token
  end
end

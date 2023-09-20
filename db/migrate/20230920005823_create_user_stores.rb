class CreateUserStores < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stores do |t|
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end

    add_index :user_stores, [:user_id, :store_id], unique: true
  end
end

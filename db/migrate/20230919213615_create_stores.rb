class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.references :state, foreign_key: true # Creates a state_id column and sets up the foreign key
      t.string :store_name, limit: 64, null: false, default: ''
      t.string :address,    limit: 64, null: false, default: ''
      t.string :address2,   limit: 64, default: nil
      t.string :city,       limit: 64, null: false, default: ''
      t.string :zip_code,   limit: 10, null: false, default: ''
      t.boolean :archived,             null: false, default: false
      t.timestamps
    end

    # We're going to assume that the name and zip code are unique; IOW,
    # there will be no two stores with the same name and zip code.
    add_index :stores, [:store_name, :zip_code], unique: true
  end
end

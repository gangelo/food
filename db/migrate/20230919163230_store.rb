class Store < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name,     limit: 64, null: false, default: ''
      t.string :street_1, limit: 64, null: false, default: ''
      t.string :street_2, limit: 64, default: nil
      t.string :city,     limit: 64, null: false, default: ''
      t.string :state,    limit: 2, null: false, default: ''
      t.string :zip_code, limit: 10, null: false, default: ''
      t.timestamps
    end

    # We're going to assume that the name and zip code are unique; IOW,
    # there will be no two stores with the same name and zip code.
    add_index :stores, [:name, :zip_code], unique: true
  end
end

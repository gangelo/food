class CreateShoppingLists < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_lists do |t|
      t.string :shopping_list_name, limit: 64, null: false, default: ''
      t.date :week_of
      t.text :notes, limit: 512
      t.boolean :template, null: false, default: false

      t.timestamps
    end

    add_index :shopping_lists, [:shopping_list_name, :week_of], unique: true
  end
end

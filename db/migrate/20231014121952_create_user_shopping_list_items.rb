class CreateUserShoppingListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :user_shopping_list_items do |t|
      t.references :user_shopping_list, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end

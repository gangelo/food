class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states do |t|
      t.string :name,                limit: 14, null: false, default: ''
      t.string :postal_abbreviation, limit: 2, null: false, default: ''

      t.timestamps
    end

    add_index :states, :name, unique: true
    add_index :states, :postal_abbreviation, unique: true
  end
end

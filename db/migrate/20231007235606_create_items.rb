class CreateItems < ActiveRecord::Migration[7.0]
  def up
    create_table :items do |t|
      t.string :item_name, limit: 64, null: false, default: ''
      t.boolean :archived, null: false, default: false

      t.timestamps
    end

    execute <<-SQL
      CREATE UNIQUE INDEX index_items_on_lower_item_name
        ON items (LOWER(item_name));
    SQL
  end

  def down
    puts "Rolling back migration \"#{self.class.name}\"..."

    puts 'Rolling back index...'
    execute <<~SQL
      DROP INDEX index_items_on_lower_item_name;
    SQL

    puts 'Dropping items table...'
    drop_table :items

    puts 'Done.'
  end
end

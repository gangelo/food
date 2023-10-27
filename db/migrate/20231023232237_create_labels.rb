class CreateLabels < ActiveRecord::Migration[7.0]
  def up
    create_table :labels do |t|
      t.string :label_name
      t.boolean :archived, null: false, default: false

      t.timestamps
    end

    execute <<-SQL
    CREATE UNIQUE INDEX index_labels_on_lower_label_name
      ON labels (LOWER(label_name));
    SQL


    add_index :labels, :label_name, unique: true
  end

  def down
    puts "Rolling back migration \"#{self.class.name}\"..."

    puts 'Rolling back index...'
    execute <<~SQL
      DROP INDEX index_labels_on_lower_label_name;
    SQL

    puts 'Dropping items table...'
    drop_table :labels

    puts 'Done.'
  end
end

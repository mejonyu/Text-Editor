class CreatePoems < ActiveRecord::Migration[6.1]
  def change
    create_table :poems do |t|
      t.string :title
      t.text :content
      t.string :poem_type
      t.string :last_editor
      t.boolean :edited?

      t.timestamps
    end
  end
end

class CreateEssays < ActiveRecord::Migration[6.1]
  def change
    create_table :essays do |t|
      t.string :title
      t.text :content
      t.string :essay_type
      t.string :last_editor
      t.boolean :edited?

      t.timestamps
    end
  end
end

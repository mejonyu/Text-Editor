class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :topic
      t.string :last_editor
      t.boolean :edited?

      t.timestamps
    end
  end
end

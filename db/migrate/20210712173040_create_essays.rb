class CreateEssays < ActiveRecord::Migration[6.1]
  def change
    create_table :essays do |t|
      t.string :title
      t.text :content
      t.string :type

      t.timestamps
    end
  end
end

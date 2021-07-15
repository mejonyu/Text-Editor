class CreatePoemContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :poem_contributors do |t|
      t.integer :user_id
      t.integer :poem_id

      t.timestamps
    end
  end
end

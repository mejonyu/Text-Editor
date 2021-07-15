class CreateEssayContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :essay_contributors do |t|
      t.integer :user_id
      t.integer :essay_id

      t.timestamps
    end
  end
end

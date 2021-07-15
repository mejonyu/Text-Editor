class CreateBlogContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_contributors do |t|
      t.integer :user_id
      t.integer :blog_id

      t.timestamps
    end
  end
end

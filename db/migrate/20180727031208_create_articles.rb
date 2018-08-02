class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.string :link
      t.string :date
      t.integer :feed_id

      t.timestamps
    end
  end
end

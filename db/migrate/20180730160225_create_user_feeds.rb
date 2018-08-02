class CreateUserFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :user_feeds do |t|
      t.integer :user_id
      t.integer :feed_id
    end
  end
end

class AddLinkAndImageToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :link, :string
    add_column :feeds, :image, :string
  end
end

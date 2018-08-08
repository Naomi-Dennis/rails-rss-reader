class AddBackgroundToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :background, :string, default: "default_backgrounds/background-2.jpg"
  end
end

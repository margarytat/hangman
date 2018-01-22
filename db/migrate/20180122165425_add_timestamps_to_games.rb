class AddTimestampsToGames < ActiveRecord::Migration[5.1]
  def up
    add_timestamps :games
  end

  def down
    remove_column :games, :created_at
    remove_column :games, :updated_at
  end
end
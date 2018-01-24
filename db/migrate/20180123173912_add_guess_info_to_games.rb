class AddGuessInfoToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :current_guesses, :string, array: true, default: '{}'
  end
end

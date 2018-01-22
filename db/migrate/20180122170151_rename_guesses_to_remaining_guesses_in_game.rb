class RenameGuessesToRemainingGuessesInGame < ActiveRecord::Migration[5.1]
  def up
    rename_column :games, :num_wrong_guesses, :num_wrong_guesses_remaining
  end

  def down
    rename_column :games, :num_wrong_guesses_remaining, :num_wrong_guesses
  end
end

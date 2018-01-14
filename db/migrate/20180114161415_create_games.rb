class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.string :word
      t.boolean :user_won
      t.integer :num_wrong_guesses
    end
    add_index :games, :word
  end
end

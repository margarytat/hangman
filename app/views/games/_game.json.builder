json.extract! game, :id, :word, :user_won, :num_wrong_guesses
json.url game_url(game, format: :json)
class Game < ApplicationRecord
  belongs_to :user, optional: true
  #  dependent?
  #  when a user deletes their account, we want to keep their games => users must stay in the database forever, just be deactivated

  # want timestamp of last update so a batch job could clean up stale unfinished games
  # and we could log finished games somewhere?
  validates :word, presence: true
  validates :num_wrong_guesses_remaining, presence: true
  # user_won will be null until the game is over

  MAX_NUM_WRONG_GUESSES = 10

  def initialize(user)
    super({})
    @user = user
    @word = ::WordProvider.random_word
    @num_wrong_guesses_remaining = MAX_NUM_WRONG_GUESSES

    puts "user is #{user}"
  end
end

# Current plan:
# DB: game_id, user_id, word, num_guesses_remaining

# 1. Client sends request to create new game (with optional user_id)
# 2. Server responds with game id, number of blank letters, number of remaining bad guesses (10)
# 3. Client displays empty gallows and word with any dash or apostrophe filled in and the rest blank
# 4. Client displays an alphabet of clickable letters (maybe qwerty)
# 5. User clicks on letter. The link becomes disabled
# 6. Client sends letter guess to Server
# 7. Server responds with number of remaining bad guesses (9)
# 8. Client updates the image displayed
# 9. Client sends next guess to Server
# 10. Server responds with an array of positions that letter is in the word and the same number of remaining guesses
# 11. Client displays letter in those positions.


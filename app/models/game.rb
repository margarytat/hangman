
class Game < ApplicationRecord
  belongs_to :user, optional: true
  #  when user closes account, there are 2 options for their games:
  # 1. set the user to null or keep existing user id and when the user is not found, display "guest" instead
  # 2. we don't delete rows in the users table, just deactivate them. former users can be or not be included in statistics

  def self.MAX_NUM_WRONG_GUESSES 
    10
  end

  def initialize
    super
    self.word = ::Services::WordProvider.random_word[0].downcase
  end

  def process_guess(guess) 
    # ignore duplicate guesses
    if !self.current_guesses.include? guess.to_s.downcase
      self.current_guesses.push(guess.to_s.downcase)
      if !self.word.downcase.include? guess.to_s.downcase
        self.num_wrong_guesses_remaining -= 1
      end
    end

  end

end

class Game < ApplicationRecord
  belongs_to :user, optional: true
  #  when user closes account, there are 2 options for their games:
  # 1. set the user to null or keep existing user id and when the user is not found, display "guest" instead
  # 2. we don't delete rows in the users table, just deactivate them. former users can be or not be included in statistics

  validates :word, presence: true
  validates :num_wrong_guesses_remaining, presence: true

  def self.MAX_NUM_WRONG_GUESSES
    10
  end

  def set_word(word_source)
    self.word = ::Services::WordProvider.random_word(word_source)[0].downcase
  end

  def process_guess(guess)
    if self.user_won == nil
      # ignore duplicate guesses
      if !self.current_guesses.include? guess.to_s.downcase
        self.current_guesses.push(guess.to_s.downcase)
        if !self.word.downcase.include? guess.to_s.downcase
          self.num_wrong_guesses_remaining -= 1
        end
      end

      num_hidden_letters = 0
      self.word.downcase.each_char do |c|
        if (c.to_s.match /[a-zA-Z]/ ) && (!self.current_guesses.include? c.to_s.downcase)
          num_hidden_letters += 1
        end
      end

      if self.num_wrong_guesses_remaining == 0
        self.user_won = false
      elsif num_hidden_letters == 0
        self.user_won = true
      end
    end
  end
end

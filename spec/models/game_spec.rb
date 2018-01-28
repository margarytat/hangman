require 'rails_helper'
require 'word_provider'
# require 'Game'

RSpec.describe Game, :type => :model do
  it "is valid with valid attributes" do
    game = Game.new(user_id: 1, word: "cucumber", num_wrong_guesses_remaining: 23)
    expect(game).to be_valid
  end
  it "is valid without user" do
    game = Game.new(word: "potato", num_wrong_guesses_remaining: 23)
    expect(game).to be_valid
  end
  it "is not valid without a word" do
    game = Game.new(num_wrong_guesses_remaining: 23)
    expect(game).to_not be_valid
  end
  it "is not valid without num_wrong_guesses_remaining" do
    game = Game.new(word: "tomato")
    expect(game).to_not be_valid
  end

  describe "#set_word" do
    context "when word uses upper case" do
      it "converts it to lower case" do
        provider = class_double("::Services::WordProvider", random_word: ["VEGETABLE"]).as_stubbed_const
        game = Game.new(num_wrong_guesses_remaining: 10)
        game.set_word("valid source")
        expect(game.word).to eql "vegetable"
      end
    end
  end

  describe "#process_guess" do

    context "with non-word letter after game has ended" do
      it "does not change number of remaining guesses" do
        guesses = ["a", "b", "s", "k"]
        game = Game.new(word: "ask", num_wrong_guesses_remaining: 9, user_won: true, current_guesses: guesses)
        game.process_guess("b")
        expect(game.num_wrong_guesses_remaining).to eq 9
      end
    end

    context "when given letter not yet guessed" do
      it "adds letter to list of guesses" do
        game = Game.new(word: "turbine", num_wrong_guesses_remaining: 8, current_guesses: ["a", "b"])
        game.process_guess("t")
        expect(game.current_guesses).to eql ["a", "b", "t"]
      end
    end

    context "when given letter not in word" do
      it "decrements number of remaining guesses" do
        game = Game.new(word: "fairy", num_wrong_guesses_remaining: 5)
        game.process_guess("e")
        expect(game.num_wrong_guesses_remaining).to eq 4
      end
    end

    context "when given letter in word" do
      it "does not change number of remaining guesses" do
        game = Game.new(word: "tale", num_wrong_guesses_remaining: 7)
        game.process_guess("l")
        expect(game.num_wrong_guesses_remaining).to eq 7
      end
    end

    context "when given already guessed non-word letter" do
      it "does not change number of remaining guesses" do
        game = Game.new(word: "row", num_wrong_guesses_remaining: 8, current_guesses: ["g", "h"])
        game.process_guess("g")
        expect(game.num_wrong_guesses_remaining).to eq 8
      end
    end

    context "when given last hidden letter" do
      it "marks game as won by user" do
        game = Game.new(word: "cat", num_wrong_guesses_remaining: 10, current_guesses: ["c", "t"])
        game.process_guess("a")
        expect(game.user_won).to eql true
      end
    end

    context "with 1 remaining guess and a non-word letter" do
      it "marks game as lost by user" do
        game = Game.new(word: "dog", num_wrong_guesses_remaining: 1)
        game.process_guess("b")
        expect(game.user_won).to eql false
      end
    end

    context "when word has non-letter characters" do
      it "should not make user guess them" do
        guesses = ["h", "a", "l", "f", "m", "s"]
        game = Game.new(word: "half-mast", num_wrong_guesses_remaining: 10, current_guesses: guesses)
        game.process_guess("t")
        expect(game.user_won).to eql true
      end
    end
  end
end
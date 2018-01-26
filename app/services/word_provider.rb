require 'csv'
module Services
  class WordProvider

    def self.random_word
      @dictionary ||= CSV.read("wordsapi_sample.csv")
      return @dictionary.sample
    end

  end
end


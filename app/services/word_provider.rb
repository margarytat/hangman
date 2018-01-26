require 'csv'
module Services
  class WordProvider

    def self.providers
      providers = Hash.new
      providers["200 hard hangman words"] = "data/200_hard_hangman_words.csv"
      providers["bizarre dictionary sample"] = "data/wordsapi_sample.csv"
      return providers
    end

    def self.random_word(source)
      @dictionaries ||= Hash.new do |h, key|
        h[key] = CSV.read(key)
      end
      return @dictionaries[source].sample
    end



  end
end


require 'csv'
class WordProvider
  @@dictionary ||= CSV.read("wordsapi_sample.csv")

  # def self.dictionary
  #   @@dictionary ||= CSV.read("wordsapi_sample.csv")
  #   puts "dictionary accessed/initialized"
  # end

  def self.random_word
    "civilization"
  end

end


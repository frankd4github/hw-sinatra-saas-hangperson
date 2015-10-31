class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter.nil? or
      letter.length != 1 or
      letter !~ /[a-zA-Z]/
    dletter = letter.downcase
    return false if @guesses.include? dletter or @wrong_guesses.include? dletter
    if @word.include? dletter
      @guesses << dletter
    else
      @wrong_guesses << dletter
    end
    return true 
  end
  
  def word_with_guesses
    not_yet_guessed = (@word.chars - @guesses.chars).uniq.reduce('', :+)
    @word.tr not_yet_guessed, '-'
  end
  
  def check_win_or_lose
    return :win if @word.chars.uniq.length == @guesses.length
    return :lose if @wrong_guesses.length >= 7
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

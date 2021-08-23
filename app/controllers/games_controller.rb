require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    @alphabet = ('a'..'z').to_a
    10.times { @letters << @alphabet.sample }
  end

  def score
    @word = params[:submission]
    @letters = params[:letters]
    if in_grid(@word, @letters) && english(@word)
      @feedback = 'a valid word'
    elsif in_grid(@word, @letters)
      @feedback = 'not an English word'
    else
      @feedback = 'not in the grid'
    end
  end

  def english(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    result = URI.open(url).read
    word_info = JSON.parse(result)
    word_info["found"]
  end

  def in_grid(attempt, letters)
    attempt_array = attempt.downcase.chars
    in_grid = true
    attempt_array.each { |letter| in_grid = false if attempt_array.count(letter) > letters.count(letter) }
    in_grid
  end
end

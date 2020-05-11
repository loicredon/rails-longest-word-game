require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = generate_grid(10)
    @start_time = Time.now
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:attempt].upcase
    @letters = params[:letters]
    json = computing(@word)
    @ok = json['found']
    @length = json['length']
  end

  def computing(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word.downcase}")
    json = JSON.parse(response.read.to_s)
    @length = json["length"]
  end

  def correct?(guess, letters)
    guess.split("").all? { |letter| letters.include? letter }
  end

end

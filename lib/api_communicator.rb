require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_info = []
  character_hash["results"].each do |character_info_hash|
    if character == character_info_hash["name"].downcase
      films_array = character_info_hash["films"]
      films_array.each do |film_url|
        films_info << RestClient.get(film_url)
      end
    end
  end
  films_info
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_info)
  # some iteration magic and puts out the movies in a nice list
  films_info.each do |film|
    film_hash = JSON.parse(film)
    puts film_hash["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# films_info = get_character_movies_from_api("luke skywalker")
# parse_character_movies(films_info)
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

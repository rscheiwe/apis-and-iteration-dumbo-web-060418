require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  #binding.pry

  film_urls = []
  character_hash["results"].map do |item|
    if item["name"] == character
      film_urls << item["films"]
      #puts item["films"]
    end
  end

  films_array = []

  film_urls.flatten.each do |film|
    film_info = RestClient.get(film)
    films_array << JSON.parse(film_info.body) #array of hashes containing film info
  end
  #binding.pry


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  #puts films
  films_array
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice
  #films_hash is an ARRAY!!!
  movie_info = {}

  films_hash.each do |info_hash|
    info_hash.each do |key, value|
      if key == "title"
        puts "==========" #value is the titles of the movies as strings
        puts "#{value}"
        puts "Director: #{info_hash['director']}"
        puts "Producer: #{info_hash['producer']}"
        puts "Release Date:: #{info_hash['release_date']}"
        puts "=========="
        # if title_hash[key]
        #   title_hash[key] = value
        # else
        #   title_hash[key] = []
        #   title_hash[key] = value
        # end
      end
    end
    # info_hash.each do |key, value|
    #   {
    #     "#{key}: #{value}"
    #   }
    # end
  end

puts "movie_info = #{movie_info}"

end

# films_hash = get_character_movies_from_api("Luke Skywalker")
# parse_character_movies(films_hash)


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

show_character_movies("C-3PO")

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

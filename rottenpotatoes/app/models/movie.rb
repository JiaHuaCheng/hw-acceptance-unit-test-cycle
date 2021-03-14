class Movie < ActiveRecord::Base
  def self.all_ratings
		['G','PG','PG-13','R']
  end
    
  def find_with_the_same_director
    Movie.where(director: director).where.not(id: id).take  # find out same director but the id is not same as @movie.  use .take to return a object
  end
end

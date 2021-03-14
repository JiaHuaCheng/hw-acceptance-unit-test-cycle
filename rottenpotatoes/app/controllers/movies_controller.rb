class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update, :destroy, :find_with_the_same_director]

  def show
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session.delete(:ratings_to_show) if params[:ratings].nil? and params[:commit] # params[:commit] is activated when we push buttom. Deselect all and push then clean. 
    session.delete(:sort_by) if params[:ratings].nil? and params[:commit]
    
    @sort_by = params[:sort_by] || session[:sort_by] 
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings] || session[:ratings_to_show]

    # use session to store previous result
    session[:ratings_to_show] = @ratings_to_show
    session[:sort_by] = @sort_by
    
    @ratings_to_show.nil? ? @movies = Movie.all : @movies = Movie.where(rating: @ratings_to_show.keys)

    @movies = @movies.order(@sort_by)
  end

  def new
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
  end

  def update
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def find_with_the_same_director
    @new_movie = @movie.find_with_the_same_director
    # if exist a movie with same director but different id 
    if @new_movie
      redirect_to movie_path(@new_movie)
    else
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to root_url
    end
  end

  private
  
  def set_movie
    @movie = Movie.find(params[:id])
  end
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end

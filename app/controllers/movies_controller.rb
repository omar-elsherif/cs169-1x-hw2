#Finished hw2

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
''' Kept to remember algorithm
def sortByName(movies)
  newMovies = []
  
  while movies.length > 0
    tempMovie = movies[0]
    movies.delete_at(0)
    
    for i in (0..newMovies.length-1)
      if tempMovie.title < newMovies[i].title
        newMovies.insert(i, tempMovie)
        tempMovie = nil
        break
      end
    end
    
    if tempMovie != nil
      newMovies << tempMovie
    end
  end
  
  return newMovies
end
'''
  def index
    @movies = Movie.all
    @all_ratings = Movie.ratings
    
    redirect = false
    
    @ratings = params[:ratings]
    
    if @ratings == nil
      @ratings = session[:ratings]
      if @ratings == nil
        @ratings = {}
        @all_ratings.each do |rating|
          @ratings[rating] = 1
        end
        session[:ratings] = @ratings
      end
      params[:ratings] = @ratings
      redirect = true
    else
      session[:ratings] = @ratings
    end
    
    @sort = params[:sort]
    
    if @sort == nil
      if request.referrer != nil
        @sort = session[:sort]
      end
      if @sort == nil
        @sort = ""
      else
        params[:sort] = session[:sort]
        redirect = true
      end
    else
      session[:sort] = @sort
    end
    
    if redirect
      redirect_to(:action => "index", :sort => @sort, :ratings => @ratings) and return
    end
    
    @movies = Movie.getByRating(@ratings.keys, @sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

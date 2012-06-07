class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if (session[:ratings] && !params[:ratings]) && (session[:sort] && !params[:sort])
      redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    else
      session[:ratings] = params[:ratings] || session[:ratings]
      session[:sort] = params[:sort] || session[:sort]
    end
    @ratings = @all_ratings = Movie.ratings
    if params[:ratings]
      @ratings = params[:ratings].select { |k,v| v == '1'}.keys
    end
    @movies = Movie.where(:rating => @ratings).order(params[:sort]).all
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

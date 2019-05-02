require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post '/songs' do
    slug_name = params[:artists][:name].gsub(" ", "-").downcase
    artist = Artist.find_by_slug(slug_name)
    if !artist
      artist = Artist.create(params[:artists])
    end

    @song = Song.new(params[:songs])
    @song.artist_id = artist.id
    @song.save

    params[:genres].each do |genre|
      new_line_item = SongGenre.create(genre_id: genre.to_i, song_id: @song.id)
    end

    if @song.save
      flash[:message] = "Successfully created song."
      redirect to "/songs/#{@song.slug}"
    else
      flash[:message] = "Error - try again."
      redirect to "/songs/new"
    end
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    # artist = Artist.find_by_slug(params[:artists][:name].gsub(" ", "-").downcase)
    # if !artist
    #   artist = Artist.create(params[:artists])
    # end
    # = artist

    # if (params[:genres] != nil) && (params[:genres] != @song.genres.collect {|genre| genre.id.to_s})
    #     @song.genres.clear!
    #   params[:genres].each do |genre|
    #     @song.genres << Genre.find(genre)
    #     @song.save
    #   end
    # end

    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end


end

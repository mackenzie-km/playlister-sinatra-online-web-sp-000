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

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch "/songs/:slug" do

    artist_slug = params[:artists][:name].gsub(" ", "-").downcase
    artist = Artist.find_by_slug(artist_slug)
    if !artist
      artist = Artist.create(params[:artists])
    end

    @song = Song.find_by_slug(params[:slug])
    @song.artist_id = artist.id
    @song.save

    # if params[:genres] != @song.genres
    # params[:genres].each do |genre|
    #   new_line_item = SongGenre.create(genre_id: genre.to_i, song_id: @song.id)
    # end

    if @song.save
      flash[:message] = "Successfully updated song."
      redirect to "/songs/#{params[:slug]}"
    else
      flash[:message] = "Error - try again."
      redirect to "/songs/#{params[:slug]}/edit"
    end
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end
end

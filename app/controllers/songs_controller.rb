class SongsController < ApplicationController

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

    # genre_list = []
    #   params[:genres].each do |g_id|
    #     genre_list << Genre.find_or_create_by(id: g_id)
    #   end
    @song = Song.new(params[:songs])
    @song.artist_id = artist.id
    @song.genre_id = params[:genres].first.to_i
    @song.save

    if @song.save
      flash[:message] = "Successfully created song."
      redirect to "/songs/#{@song.slug}"
    else
      flash[:message] = "Error - try again."
      redirect to "/songs/new"
    end
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end
end

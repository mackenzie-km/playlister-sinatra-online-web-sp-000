class ArtistsController < ApplicationController

  get '/artists' do
    erb :'/views/artists/index'
  end

end

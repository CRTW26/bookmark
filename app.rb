# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  # before do
  #   @bookmark = Bookmark
  # end

  get '/' do 
    erb(:index)
  end 

  get '/add_bookmark' do 
    erb(:add_bookmark)
  end 

  post '/add_to_database' do 
    url = params[:bookmark]
    Bookmark.create(url)
    redirect '/confirmation'
  end 

  get '/confirmation' do
    "Bookmark Added!" 
  end 

  get '/bookmarks' do
    p ENV['RACK_ENV']
    @bookmark = Bookmark.all
    erb(:bookmark)
  end

  run! if app_file == $0
end

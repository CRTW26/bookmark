# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
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
    title = params[:title]
    Bookmark.create(url, title)
    redirect '/confirmation'
  end 

  get '/confirmation' do
    "Bookmark Added!" 
  end 

  get '/bookmarks' do
    @bookmark_list = Bookmark.all
    erb(:bookmark)
  end

  delete '/bookmarks/:id' do 
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'   
  end 

  post '/bookmarks/:id' do 
    Bookmark.update(params[:id], params[:title], params[:url])
    # @connection = PG.connect(dbname: 'bookmark_manager')
    # @connection.exec("UPDATE bookmarks SET title = '#{params[:title]}', url = '#{params[:url]}' WHERE id = '#{params[:id]}'")
    redirect '/bookmarks'
  end 

  run! if app_file == $0
end

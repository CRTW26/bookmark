# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark'
require 'uri'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  # before do
  #   @bookmark = Bookmark
  # end

  get '/' do 
    erb(:index)
  end 

  get '/flash' do 
    flash[:invalid] = "Flash"
    redirect '/'
  end 

  get '/add_bookmark' do 
    erb(:add_bookmark)
  end 

  post '/add_to_database' do 
    flash[:invalid] = 'Invalid URL entered'
    url = params[:bookmark]
    title = params[:title]
    if params[:bookmark] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(url, title)
    else 
      flash[:invalid] 
    end  
    redirect '/bookmarks'
  end 

   get '/' do
     "Bookmark Added!" 
   end 


  get '/bookmarks' do
    @bookmark_list = Bookmark.all
    erb(:bookmark)
  end

  delete '/bookmarks/:id' do 
    # Bookmark.delete(params[:id])
    # redirect '/bookmarks'  
    connection = PG.connect(dbname: 'bookmark_manager')
    connection.exec("DELETE FROM bookmarks WHERE id = #{params['id']}") 
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

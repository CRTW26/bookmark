# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  # before do
  #   @bookmark = Bookmark
  # end

  get '/bookmarks' do
    p ENV['RACK_ENV']
    @bookmark = Bookmark.all
    erb(:bookmark)
  end

  run! if app_file == $0
end

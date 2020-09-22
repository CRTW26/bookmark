# frozen_string_literal: true
require 'pg'
class Bookmark
  attr_reader :bookmark, :connection
  BOOKMARKS = ['www.google.com', 'www.reddit.com', 'www.youtube.com'].freeze

  def self.all
    Bookmark.set_environment
    table = @connection.exec('SELECT url FROM bookmarks')
    urls = []
    table.each { |url| urls << url.values.join('')}
    urls.join('\n')
  end

  def self.create(url)
    Bookmark.set_environment
    @connection.exec("INSERT INTO bookmarks (url) VALUES ('#{url}');")
  end
  
  def self.set_environment 
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else 
      @connection = PG.connect(dbname: 'bookmark_manager')
    end 
  end 

end

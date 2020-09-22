# frozen_string_literal: true
require 'pg'
class Bookmark
  attr_reader :bookmark, :connection
  BOOKMARKS = ['www.google.com', 'www.reddit.com', 'www.youtube.com'].freeze

  def self.all
    Bookmark.set_environment
    table = @connection.exec('SELECT title FROM bookmarks')
    titles = []
    table.each { |title| titles << title.values.join('')}
    urls.join('\n')
  end

  def self.create(url, title)
    Bookmark.set_environment
    @connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}');")
  end
  
  def self.set_environment 
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else 
      @connection = PG.connect(dbname: 'bookmark_manager')
    end 
  end 

end

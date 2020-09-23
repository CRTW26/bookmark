# frozen_string_literal: true
require 'pg'
class Bookmark
  attr_reader :connection, :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url 
  end 

  def self.all
    Bookmark.set_environment
    result = @connection.exec('SELECT * FROM bookmarks')
    result.map {|bookmark| Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])}
  end

  def self.create(url, title)
    Bookmark.set_environment
    result = @connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end
  
  def self.set_environment 
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else 
      @connection = PG.connect(dbname: 'bookmark_manager')
    end 
  end 

end

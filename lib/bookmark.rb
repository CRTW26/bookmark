# frozen_string_literal: true
require 'pg'
require './lib/databaseconnection.rb'
class Bookmark
  attr_reader :connection, :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url 
  end 

  def self.all
    Bookmark.set_environment
    result = DatabaseConnection.query('SELECT * FROM bookmarks')
    result.map {|bookmark| Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])}
  end

  def self.create(url, title)
    Bookmark.set_environment
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.delete(id)
    Bookmark.set_environment
    DatabaseConnection.query("DELETE * FROM bookmarks WHERE id = #{id}")
  end
  
  def self.update(id, new_title, new_url)
   Bookmark.set_environment
   DatabaseConnection.query("UPDATE bookmarks SET title = '#{new_title}', url = '#{new_url}' WHERE id = '#{id}'")
  end 

  private 
  
  def self.set_environment 
    if ENV['RACK_ENV'] == 'test'
      DatabaseConnection.setup('bookmark_manager_test')
    else 
      DatabaseConnection.setup('bookmark_manager')
    end 
  end 

end

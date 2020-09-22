# frozen_string_literal: true
require 'pg'
class Bookmark
  BOOKMARKS = ['www.google.com', 'www.reddit.com', 'www.youtube.com'].freeze

  def all
    connection = PG.connect(dbname: 'bookmark_manager')#when we get an error on yours its an underscore
    table = connection.exec('SELECT url FROM bookmarks')
    urls = []
    table.each { |url| urls << url.values.join('')}
    urls.join('\n')
  end

  
end

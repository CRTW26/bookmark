# frozen_string_literal: true
require 'pg'
class Bookmark
  attr_reader :bookmark
  BOOKMARKS = ['www.google.com', 'www.reddit.com', 'www.youtube.com'].freeze

  def self.all
    if ENV['ENVIRONMENT'] = 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else 
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    #connection = PG.connect(dbname: 'bookmark_manager')
    table = connection.exec('SELECT url FROM bookmarks')
    urls = []
    table.each { |url| urls << url.values.join('')}
    urls.join('\n')
  end

  
end

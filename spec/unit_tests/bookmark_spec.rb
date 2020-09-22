require 'bookmark'

RSpec.describe Bookmark do 

  describe '#create' do 

    it 'adds bookmark to database' do 
      Bookmark.create('www.google.com')
      expect(Bookmark.all).to include 'www.google.com'
    end 

  end 
end 
require 'bookmark'

RSpec.describe Bookmark do 

  describe '#create' do 

    it 'adds bookmark to database' do 
      bookmark = Bookmark.create('www.youtube.com', "YouTube")
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'YouTube'
      expect(bookmark.url).to eq 'www.youtube.com'
    end 

  end 

  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
   
      # Add the test data
      bookmark = Bookmark.create("http://www.makersacademy.com", "Makers Academy")
      Bookmark.create("http://www.destroyallsoftware.com", "Destroy All Software")
      Bookmark.create("http://www.google.com", "Google")
   
      bookmarks = Bookmark.all
   
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
     end
   end

   describe '.delete' do
    it 'deletes bookmark selected' do 
     bookmark = Bookmark.create("http://www.makersacademy.com", "Makers Academy") 
     Bookmark.delete(id: bookmark.id)
     expect(Bookmark.all.length).to eq 0
    end 
  end
  
  describe '.update' do 
    it 'updates bookmark' do
      bookmark = Bookmark.create("http://www.makersacademy.com", "Makers Academy") 
      Bookmark.update(540, 'google', 'www.google.com')
      expect(Bookmark.all[0].title).to include('google')
      expect(Bookmark.all[0].title).not_to include('Makers Academy')
    end 
  end 

end 
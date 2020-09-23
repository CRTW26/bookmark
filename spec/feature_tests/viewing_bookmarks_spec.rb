# frozen_string_literal: true

feature 'viewing bookmarks' do
  scenario '/bookmarks shows a list of bookmarks' do
    Bookmark.create('http://www.makersacademy.com','Makers Academy')
    Bookmark.create('http://www.destroyallsoftware.com','Destroy All Software')
    Bookmark.create('http://www.google.com', 'Google')

    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end


end

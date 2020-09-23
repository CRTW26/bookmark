feature 'deleting a bookmark' do 
  scenario 'user can delete a bookmark' do 
    Bookmark.create('http://www.makersacademy.com','Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    click_on('Delete')
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end 
end 

feature 'update existing bookmark' do 
  scenario 'user can update bookamrk in db' do 
    Bookmark.create('http://www.makersacademy.com','Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    fill_in :title, with: 'google'
    fill_in :url, with: 'www.google.com'
    click_on('Update')
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('google', href: 'www.google.com')
  end 
end 

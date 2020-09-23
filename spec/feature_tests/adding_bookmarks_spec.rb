feature 'adding a bookmark' do 
  scenario 'user can add a bookmark' do 
    visit'/'
    click_on('Add bookmark')
    fill_in :bookmark, with: 'www.google.com'
    fill_in :title, with: 'google'
    click_on('Add bookmark')
    expect(page).to have_content 'Bookmark Added!'
  end 
end 
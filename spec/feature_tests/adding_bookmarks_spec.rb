feature 'adding a bookmark' do 
  scenario 'user can add a bookmark' do 
    visit'/'
    click_on('Add bookmark')
    fill_in :bookmark, with: 'http://www.google.com'
    fill_in :title, with: 'google'
    click_on('Add bookmark')
    expect(page).to have_content 'google'
  end 
end

feature 'error if incorrect URL format' do 
  scenario 'user receives error messgae if URL incorrect' do 
    visit'/'
    click_on('Add bookmark')
    fill_in :bookmark, with: 'google.com'
    fill_in :title, with: 'google'
    click_on('Add bookmark')
    expect(page).to have_content 'Invalid URL'
  end
end 
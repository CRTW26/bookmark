# frozen_string_literal: true

feature 'viewing bookmarks' do
  scenario '/bookmarks shows a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');
    INSERT INTO bookmarks (url) VALUES ('http://askjeeves.com');
    INSERT INTO bookmarks (url) VALUES ('http://twitter.com');
    INSERT INTO bookmarks (url) VALUES ('http://www.google.com');
    DELETE from bookmarks WHERE url='http://twitter.com';
    UPDATE bookmarks SET url = 'http://www.destroyallsoftware.com' WHERE url = 'http://askjeeves.com';")


    visit('/bookmarks')
    expect(page).to have_content 'http://www.makersacademy.com'
    expect(page).to have_content 'http://www.google.com'
    expect(page).to have_content 'http://www.destroyallsoftware.com'
  end


end

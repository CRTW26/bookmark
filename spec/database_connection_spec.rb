describe DatabaseConnection do
  it "is a database connection" do
    model_connection = PG.connect(dbname: 'bookmark_manager_test')
    expect(DatabaseConnection.setup('bookmark_manager_test').class).to eq model_connection.class
  end
  it "can receive :exec" do 
    connection = DatabaseConnection.setup('bookmark_manager_test')
    expect(connection).to receive(:exec).with("SELECT * FROM bookmarks")
    DatabaseConnection.query("SELECT * FROM bookmarks")
  end
end
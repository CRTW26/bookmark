CREATE DATABASE "bookmark_manager";
\c "bookmarks";
CREATE TABLE bookmarks (id SERIAL PRIMARY KEY, url VARCHAR(60));
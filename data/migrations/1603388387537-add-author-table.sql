//create the new db from the old db
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

//create the new authors table 
CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));

//populate the new authors table with all of the unique authors
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

//add an author id column to books that we will use as the foreign key
ALTER TABLE books ADD COLUMN author_id INT;

// update the books table with the author id by matching author names
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

//we no longer need the column author in books table, so remove it
ALTER TABLE books DROP COLUMN author;

//set the foreign key in books table so it references the authors id in the authors table 
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
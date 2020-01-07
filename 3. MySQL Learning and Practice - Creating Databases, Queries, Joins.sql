# MYSQL
# Course taken:
# https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/learn/lecture/6912306#overview

# Databases are viewed in two pieces: the database itself and the database manager
# For example, SQL is the database being used while MYSQL is the database manager we are using
# Other database managers that use SQL include Oracle and PostgreSQL

# goorm.io
# Start the CLI
mysql-ctl cli;
# This initializes the mysql server on goorm.io or AWS

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# DATABASES

# List available databases
show databases;

# Creating a database
CREATE DATABASE database_name;
# EXAMPLE 
CREATE DATABASE test_db;
# Creates a database named test_db

# Dropping/deleting databases
DROP DATABASE database_name;
# EXAMPLE
DROP DATABASE test_db;
# Drops the previously created test_db database

# Using/selecting a database
CREATE DATABASE dog_walking_app;
USE dog_walking_app;
# Create a database named dog_walking_app and use it
SELECT database();
# Displays which database is currently being used

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# TABLES
# Databases contains tables, which are similar as Pandas DataFrames
# Tables contain columns
# Databases usually contain many, many tables

# ASIDE: SQL DATATYPES
# https://www.w3schools.com/sql/sql_datatypes.asp


# CREATING TABLES

# General form of table creation syntax in MYSQL

CREATE TABLE tablename
	(
		column_name data_type,
		column_name data_type
	);

# Example
CREATE TABLE cats
	(
		name VARCHAR(100),
		age INT
	);

# Show tables in database
SHOW TABLES;

# Show columns in table
SHOW COLUMNS FROM tablename;
# Example
SHOW COLUMNS FROM cats;
# Better code to show columns
DESC tablename;
# Example
DESC cats;

# Dropping tables
DROP TABLE tablename;
# Example
DROP TABLE cats;

# Let's create a table named pastries with two columns, name and quantity, display the table, display the columns then drop it altogether
CREATE TABLE pastries
	(
		name VARCHAR(100),
		quantity INT
	);

SHOW pastries
DESC pastries;
DROP TABLE pastries;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# INSERTING AND RETRIEVING DATA

# Inserting Data

# Creating a table named cats with two columns, name and age
CREATE TABLE cats
	(
		name VARCHAR(100),
		age INT
	);

# Inserting a row entry into this table
INSERT INTO cats
			(name, 
			age)
VALUES 		('Silly', 
			16);

# Display all row entries in a table
SELECT * FROM cats;

# Multiple insert 

INSERT INTO cats(name, age)
VALUES ('Fenny', 7), ('Charlie', 2), ('Sadie', 5)

# Let's create a table named 'people' with columns for first name (20 char name), last name (20 char max) and age
CREATE TABLE people
	(
		first_name VARCHAR(20),
		last_name VARCHAR(20),
		age INT
	);

 INSERT INTO people(first_name, last_name, age)
 VALUES	('Tina', 'Belcher', 20);
 		,('Bob', 'Belcher', 42);

# ASIDE: WARNINGS IN MYSQL
# Say we say VARCHAR(50), which limits us to a 50 character string. When inputting string data that is longer than 50 characters it will be entered but TRUNCATED
# Say we set INT, inputting an invalid number or a string etc. will set the value to 0
# We can view warnings with
SHOW WARNINGS;
# This will display the set of warnings
# If we run a line that produces a set of warnings but then run another valid line afterm SHOW WARNINGS; will not display the warnings!!!

# NULL and NOT_NULL
# NULL means that the value is not known
INSERT INTO cats(name)
VALUES ('Derrick')
# This will insert a row entry into the cats table with the name 'Derrick' however the age column will display NULL
# To force an entry to never be null we can create our cats table like such
CREATE TABLE cats
	(	name VARCHAR(50) NOT NULL,
		age INT NOT NULL
	);
# This is useful to always ensure entries are always present in columns we want to to MANDATORY
# Say we tried to input a row entry and we are entering NULL into a column where it is forced to be NOT NULL
# This will produce an error set telling us that we are missing a default value
# Say we tried entering a null value into the age column, we will get the warning set and SQL will automatically input the value of 0 if we do not have a default set
# Numerical fields with no default automatically default to 0
# Datetime fields with no default automatically default tot he approprirate 0 value
# String fields with no default automatically default to an empty string ''

# Default values
# Creating a table with default values
# NOTE THAT THIS TABLE CAN STILL ACCEPT NULL ENTRIES!
CREATE TABLE cats
	(
		name VARCHAR(50) DEFAULT 'Garfield',
		age INT DEFAULT 99
	);

# Creating a table with default values that will not accept null entries
CREATE TABLE cats
	(
		name VARCHAR(50) NOT NULL DEFAULT 'Garfield',
		age INT NOT NULL DEFAULT 99
	);

# Primary Keys
# Primary keys are unique identifiers on a rowm such as a USERID
CREATE TABLE unique_cats
	(
		cat_id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(50) NOT NULL DEFAULT 'Garfield',
		age INT NOT NULL DEFAULT 99,
		PRIMARY KEY (cat_id)
	);

INSERT INTO unique_cats(cat_id, name, age)
VALUES (1, 'Silly', 16), (1, 'Silly', 16);
# The above lines will return an ERROR as we set cat_id to be the same entry
# Columns that are set as primary keys must have UNIQUE values
# AUTO_INCREMENT will make it such that we do no have to enter an cat_id manually, rather SQL will generate them for us automatically and incrementally

# Let's practice by defining a table such that
# Table name: Employees
# id - integer, primary key, mandatory, automaticall increments
# last_name - text, mandatory
# first_name - text, mandatory
# middle_name - text, not mandatory
# age - integer, mandatory
# current_status - text, mandatory, defaults to 'employed'

CREATE TABLE employees
	(
		id INT NOT NULL AUTO_INCREMENT,
		last_name VARCHAR(255) NOT NULL,
		first_name VARCHAR(255) NOT NULL,
		middle_name VARCHAR(255),
		age INT NOT NULL,
		current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
		PRIMARY KEY (id)
	);

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# CRUD COMMANDS
# CREATE, READ, UPDATE, DELETE

# The basics of CRUD
# We want to be able to create data
# We want to be able to read our data
# We want to be able to update our data
# We want to be able to delete out data

# The previous section above taught us how to create our data
# Let's start with a fresh table
CREATE TABLE cats
	(
		cat_id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(100),
		breed VARCHAR(100),
		age INT,
		PRIMARY KEY (cat_id)
	);

# Insert some new entries
INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

# Reading Data
# Recall
SELECT * FROM cats;
# The * denotes to retrieve ALL columns
# We can replace * with column name to retrieve those columns only
SELECT name from cats;
SELECT name, age FROM cats;
# We can retrieve entries based on user set restrained with the WHERE keyword
# This is used to specify a group of entries we are interested in 
SELECT * FROM cats WHERE age = 4;
# * = Denotes columns to retrieve
# WHERE = Denotes rows to retrieve
SELECT * FROM cats WHERE name = 'Egg';
SELECT * FROM cats WHERE (name = 'Ringo' or name = 'Misty');

# Aliases
# We can use aliases to return the name of the columns as something else that we specify in the query
# This is useful when joining tables with identical column names
SELECT cat_id AS id, name FROM cats;

# The UPDATE command
# Update is used to alter existing data, such as a password change
UPDATE cats SET breed = 'Shorthair'
WHERE breed = 'Tabby';
# Update all Tabby cats to be of breed Shorthair
UPDATE cats SET age = 14
WHERE name = 'Misty';
# Update age to 14 for cat named Misty

# The DELETE command
DELETE FROM cats WHERE name = 'Egg';
# This delete's the cat name 'Egg' from our database
# NOTE THAT THIS DOES NOT UPDATE THE cat_id COLUMN!
# The cat_id set at creation of the row is set until changed manually, deleting an entry from the middle of the table will not reduce the ids of entries that come after

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# CRUD EXERCISES

# Create table
CREATE TABLE shirts
	(
		shirt_id INT NOT NULL AUTO_INCREMENT,
		article VARCHAR(255),
		color VARCHAR(255),
		shirt_size VARCHAR(255),
		last_worn INT,
		PRIMARY KEY (shirt_id)
	);

# Multi-Insert values
INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES 	('t-shirt', 'white', 'S', 10),
		('t-shirt', 'green', 'S', 200),
		('polo shirt', 'black', 'M', 10),
		('tank top', 'blue', 'S', 50),
		('t-shirt', 'pink', 'S', 0),
		('polo shirt', 'red', 'M', 5),
		('tank top', 'white', 'S', 200),
		('tank top', 'blue', 'M', 15);

# Insert single value
INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES 	('polo shirt', 'purple', 'M', 50);

# Select rows but only display columns article and color
SELECT article, color FROM shirts;

# Select all M shirts and display all columns except shirt_id
# Two ways to do this
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size = 'M';

# This is the way the course probably wants us to do it
# Alternatively we can create a temporary table that is a copy of this table, drop the one column that we don't want and display all columns
# SELECT INTO copies from one table to another
# LIKE copies the structure of one table to another
CREATE TABLE shirts_temp LIKE shirts;
# Create table shirts_temp with same structure as shirts
INSERT INTO shirts_temp SELECT * FROM shirts WHERE shirt_size = 'M';
# ALTER TABLE allows us to alter the structure of a table
# DROP COLUMN allows us to drop a column
ALTER TABLE shirts_temp DROP COLUMN shirt_id;
# This method is useful when we want to display most columns (for example, don't display 1 or 2 column) but we have A LOT of columns
# The reason why is we dont want to SELECT and type in 300 column names, it is easier to create a duplicate table and drop the columns we don't need
DROP TABLE shirts_temp;
# Drop the temporary table once we are done

UPDATE shirts SET shirt_size = "L"
WHERE article = 'polo shirt';
# Change all polo shirts to size L

UPDATE shirts SET last_worn = 0
WHERE last_worn = 15;
# Update the shirt last worn 15 days ago to 0 days ago (we wore it today)

UPDATE shirts SET shirt_size = 'XS', color = 'off white'
WHERE color = 'white';
# Change size to XL and color to off white for all white shirts

DELETE FROM shirts WHERE last_worn >= 200;
# Delete all shirts last worn 200 or more days ago

DELETE FROM shirts WHERE article = 'tank top';
# Delete all tank tops

DELETE FROM shirts;
# Delete all shirts

DROP TABLE shirts;
# Drop the shirts table

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# STRING FUNCTIONS IN SQL
# Just use Python, this will give you a migraine

# We will not be running SQL scripts to help us load the data
# Script was obtained from the course web page and is called book-data.sql
# File path is
# G:\Dropbox\Software Development\FILES\Udemy\MySQL Bootcamp\book-data.sql

# We will be using MySQL workbench

# Working with CONCAT
SELECT
	CONCAT(author_fname, ' ', author_lname)
AS 'Full Name'
FROM books;
# Returns one columns, Full Name, containing first name and last name with a space in between

# Alternatively we can write
SELECT author_fname AS first, author_lname AS last,
	CONCAT(author_fname, " ", author_lname) AS 'Full'
FROM books;
# Returns three columns (first, last, full) containing corresponsing entries

# We can also write
SELECT 
	CONCAT_WS('-', title, author_fname, author_lname)
FROM books;
# This will return one column containing the title, first name and last name seperated by a -

# Working with SUBSTRING
# SUBSTRING allows us to return a slice of a string
# NOTE: STRING INDICES IN MySQL START AT 1 NOT 0 AND ROW INDICES START AT 0, RETARDED
SELECT SUBSTRING('Hello World', 1, 4);
# Returns characters 1-4 both ends inclusive from the string 'Hello World' -> 'Hell'
SELECT SUBSTRING('Hello World', 7);
# Returns characters from index position 7 inclusive to the end -> 'World'
SELECT SUBSTRING('Hello World', -3);
# Returns last 3 characters -> 'rld'
SELECT SUBSTRING(title, 1, 10) as 'short title' FROM books;
# Returns all titles as short titles with first 10 characters
SELECT SUBSTRING(title, 1, 10) as 'short title' FROM books;
SELECT CONCAT(
		SUBSTRING(
			title, 1, 10
			), "..."
		) AS 'Short Title' 
FROM books;
# Takes first ten characters from the title and concatenates them to ... as Short Title

# Using REPLACE
SELECT REPLACE("Hello World", 'Hell', '@#$%')
# Replaces 'Hell', which is a bad word, with '@#$%'
SELECT SUBSTRING(REPLACE(title, 'e', '3'), 1, 10)
FROM books;
# Replaces the string 'e' with '3' and then takes the substring of the first 10 characters

# Using REVERSE()
SELECT REVERSE(title)
FROM books;
# Returns reversed titles
SELECT CONCAT(author_fname, REVERSE(author_lname))
FROM books;
# Concatenates the first name with the reversed last name

# Using CHAR_LENGTH
SELECT author_fname, CHAR_LENGTH(author_fname)
FROM books;
# Returns first name then length of first name

# Using UPPER and LOWER;
SELECT UPPER(title)
FROM books;
# Returns title in all uppercase letters

SELECT LOWER(title)
FROM books;
# Returns title in all lowercase letters

# String manipulation exercises
SELECT REVERSE(UPPER('why does my cat look at me with such hatred?'))

# Print out
# "I-like-cats"

SELECT REPLACE(title, " ", "->")
FROM books;

SELECT author_fname AS 'forwards', REVERSE(author_fname) AS 'backwards'
FROM books;

SELECT CONCAT(UPPER(author_fname), " ", UPPER(author_lname)) AS "full name in caps"
FROM books;

SELECT CONCAT(title, " was released in ", released_year) AS 'blurb'
FROM books;

SELECT title, CHAR_LENGTH(title) AS 'character count'
FROM books;

SELECT 	
CONCAT(SUBSTRING(title, 1, 10), "...") AS 'short title',
CONCAT(author_lname, ",", author_fname) AS 'author',
CONCAT(stock_quantity, " in stock") AS 'number in stock'
FROM books;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# REFINING OUR SEARCHES
# Limiting our results, sorting our results, etc.

# Let's add some more books into our table

# Using DISTINCT
# DISTINCT will return unique values only
SELECT DISTINCT author_lname FROM books;
# Returns author last names but only returns unique values, no duplicates
SELECT DISTINCT author_fname, author_lname FROM books;

SELECT DISTINCT(CONCAT(author_fname, " ", author_lname))
FROM books;
# Both above lines will return unique full names however second will return in a concatenated form

# ORDER BY
SELECT author_lname FROM books ORDER BY author_lname;
SELECT author_lname FROM books ORDER BY author_lname DESC;
# Sorts by last name alphabetically ascending then descening, also works on numerical values
SELECT title, author_fname, author_lname 
FROM books ORDER BY 3, 2;
# When selecting multiple columns we can use a number to denote the column we want to order by
# In this case we are ordering by the second column we entered which is last name, then will sort by first name if there are any errors 

# LIMIT
# Limits the amount of results that are returned
SELECT author_fname FROM books LIMIT 3;
# Returns first name but only first 3 results
SELECT title, released_year FROM books
ORDER BY released_year DESC LIMIT 1, 3
# Returns title and releaase year, sorting by release year descening, and limiting are results to 3 starting from row index 1 NON INCLUSIVE (books 3, 4 and 5)

# LIKE
SELECT * FROM books WHERE author_fname like '%da%';
# The % symbol is known as a wild card
# The above query will look for any entry that has da in the string
# If the wildcard was replaced with the worth 'anything' in plain English, it would read like
# ANYTHING da ANYTHING
SELECT * FROM books WHERE author_fname LIKE 'da%';
# This query looks for anything that STARTS with da
SELECT * FROM books WHERE author_fname LIKE '%da';
# This query looks for anything that ENDS with da
SELECT * FROM books WHERE stock_quantity LIKE '____'
# The underscore wildcard denotes a character
# For example the above query will look for stock quantities that for 4 characters long
# Four %%%% is not the same as four ____
# The % will return ANYTHING where as _ specifies the number of characters
# An example of using this would be loking for phone number, we would use LIKE '(___)-___-____'
# How do we look for entries with % or _ if these are used as wildcards?
# Similar to Python, we use \ as the escape character
# % is the wildcard \% is the string '%'

# EXERCISES
SELECT title FROM books WHERE title LIKE '%Stories%;'

SELECT title, pages
FROM books
ORDER BY 2 DESC
LIMIT 1;

SELECT CONCAT(title, ' - ', released_year)
FROM books
ORDER BY released_year DESC
LIMIT 3;

SELECT title, author_lname
FROM books
WHERE author_lname LIKE "% %";

SELECT title, released_year, stock_quantity
FROM books
ORDER BY stock_quantity ASC
LIMIT 3;

SELECT title, author_lname AS 'last name'
FROM books
ORDER BY author_lname, title;

SELECT CONCAT("MY FAVORITE AUTHOR IS ", UPPER(author_fname), " ", UPPER(author_lname), "!") as 'yell'
FROM books
ORDER BY author_lname;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# AGGREGATE FUNCTIONS

# The COUNT function
# This counts the number of books in the table
SELECT COUNT(*) 
FROM books
WHERE author_fname = 'Dave';
# Returns number of row entries where author's first name is Dave
SELECT COUNT(DISTINCT author_fname)
FROM books;
# Returns number of unique first names
SELECT COUNT(DISTINCT author_fname, author_lname)
FROM books;
# Returns number of unique full names
SELECT COUNT(title)
FROM books
WHERE title
LIKE "%the%";
#Returns number of titles that contain the word the

# GROUP BY
# Works the same as Pandas
SELECT author_fname, author_lname, COUNT(*) 
FROM books GROUP BY author_fname, author_lname;
# Returns the number of times an unique first name and last name appears in the table
# In Pandas we would write
# dataframe.group_by([author_fname, author_lname]).size()
SELECT released_year, COUNT(*)
FROM books GROUP BY released_year;
# In Pandas we would write
# dataframe.group_by('released_year').size()

# MIN and MAX
SELECT MIN(released_year)
FROM books;
# Returns earliest year a book was released
SELECT MAX(pages)
from books;
# Returns longest book
# What if we wanted to return the name of the book with the least (MIN) pages?
SELECT * FROM books
WHERE pages = (SELECT MIN(pages) FROM books);
# The above is called a SUBQUERY
# The SUBQUERY will run first
# So when the query is run, SELECT MIN(pages) FROM books will resolve first and returns 634
# Then SELECT * FROM book WHERE pages = 634 will resolve
# This will return all columns from pages = 634, thus returning us the information on the shortest book
# Subqueries are slow
# The faster way is to use ORDER BY
SELECT * 
FROM BOOKS 
ORDER BY pages ASC 
LIMIT 1;
# This returns the same result


# GROUP BY AND MIN MAX
SELECT author_lname, author_fname, MIN(released_year)
FROM books
GROUP BY author_lname, author_fname;

# SUM
SELECT CONCAT(author_fname, " ", author_lname) as 'Author', SUM(pages) AS 'Total Pages Written'
FROM BOOKS
GROUP BY author_lname, author_fname;

# AVG
SELECT AVG(released_year)
FROM books;

# Aggregate function exercises
SELECT released_year, COUNT(*) AS 'Number of Books Released'
FROM books
GROUP BY released_year;

SELECT SUM(stock_quantity) as 'Total Number of Books in Stock'
FROM books;

SELECT CONCAT(author_fname, ' ', author_lname) AS 'Author', AVG(released_year) AS 'Average Release Year'
FROM books
GROUP BY author_lname, author_fname
ORDER BY author_fname ASC;

SELECT CONTACT(author_fname, ' ', author_lname) AS 'Author', pages
FROM books
ORDER BY pages DESC
LIMIT 1;

SELECT released_year, COUNT(*) AS 'Number of Books', AVG(pages) as 'Average Pages'
FROM books
GROUP BY released_year
ORDER BY released_year ASC;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# DATA TYPES REVISITED

# CHAR has a fixed length, CHAR(3) MUST have 3 characters
# VARCHAR has variable length, VARCHAR(3) can have UP TO 3 characters
# CHAR is FASTER than VARCHAR when dealing with fixed length (important for database design)

# INT works with whole numbers/integers
# DECIMAL takes two arguemnts, Eg. DECIMAL(M, D), M is the maximum number of digits our number can have and D is the maximum decimal points MAX(M) = 65 and MAX(D) = 30
# 55.22 has 4 DIGITS and 2 DECIMAL POINTS
# DECIMAL is fixed point and calculations are exact
# FLOAT and DOUBLE are floating points and calculations are approximate
# FLOAT and DOUBLE use less memory
# Memory efficiency comes at a tradeoff of precision
# DOUBLE is the same as FLOAT but takes up more memory and is more precise, usually it is better to use DOUBLE
# We always want to use DECIMAL unless we know that precision does not matter

# Dates and times
# DATE contains the date but no timestamp
# TIME contains the time but no associated date
# DATETIME contains both
# 'YYYY-MM-DD HH:MM:SS'
# Think Pandas
CREATE TABLE people
	(
		name VARCHAR(100),
		birthdate DATE,
		birthtime TIME,
		birthdt DATETIME
	);

INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES ('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');

# CURDATE, CURTIME, NOW
# Current date, current time, current datetime
INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES('Toaster', CURDATE(), CURTIME(), NOW());

# Formatting dates
SELECT name, DAY(birthdate) FROM people;
# Extracts the day from the date
SELECT name, DAYNAME(birthdate) FROM people;
# Extracts the day from the date
SELECT name, DAYOFWEEK(birthdate) FROM people;
# Extracts the number of the day of the week (Sun = 1, Sat = 7)
SELECT name, DAYOFYEAR(birthdate) FROM people;
# Extracts the day of the year 
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h and %m') FROM people;
# Displays birth datetime as the specified formation (month/day/year at hour and minute)

# Math with dates
SELECT DATEDIFF(NOW(), birthdate) FROM people;
# Displays how many days ago the individual was born
SELECT name, DATE_ADD(birthdate, INTERVAL 10 DAYS)
FROM people;
# We can also write
SELECT name, birthdt + INTERVAL 10 DAY
FROM people;
# Adds 10 days to birthdays
SELECT name, DATE_SUB(birthdate, INTERVAL 10 DAYS)
FROM people;
# Subtract 10 days from birthdays
SELECT name, birthdt - INTERVAL 10 DAY + INTERVAL 10 HOUR
FROM people;

# TIMESTAMPS
CREATE TABLE comments(
	content VARCHAR(100),
	created_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP()
);
# Creates a table to store comments with each timestamp created at the time when the entry is added
# When the entry is updated, the timestamp will also update the NOW()
INSERT INTO comments(content)
VALUES 	('lol');
# Adds a comment

UPDATE comments SET content = 'Nevermind'
WHERE content = 'lol';

SELECT DAYNAME(NOW());

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# LOGICAL OPERATORS

# = is equals
# != is not equals
# We can use NOT LIKE to do the opposite of LIKE
# >, <, >= and <= to compare numerical values

# CASE STATEMENTS (REPLACES IF, ELIF AND ELSE)
SELECT title, released_year,
	   CASE
		 WHEN released_year >= 2000 THEN 'Modern Literature'
		 ELSE '20th Century Literature'
	   END AS 'Genre'
FROM books;

# Exercises
SELECT title, released_year 
FROM books
WHERE released_year < 1980;

SELECT title
FROM books
WHERE (author_lname = 'Eggers' OR author_lname = 'Chabon');

SELECT *
FROM books
WHERE (author_lname = 'Lahiri' AND released_year > 2000);

SELECT * 
FROM books
WHERE pages BETWEEN 100 AND 200;

SELECT * 
FROM books
WHERE (author_lname LIKE 'C%' OR author_lname LIKE 'S%');

SELECT title, author_lname,
	CASE
		WHEN title LIKE '%Stories%' THEN 'Short Stories'
		WHEN (title = 'Just Kids' OR title LIKE 'A Heartbreaking Work%') THEN 'Memoir'
		ELSE 'Novel'
	END AS 'TYPE'
FROM books;

SELECT title, author_lname, 
	CASE
		WHEN COUNT(*) = 1 THEN CONCAT(COUNT(*), ' ', 'book')
		ELSE CONCAT(COUNT(*), ' ', 'books')
	END AS 'COUNT'
FROM books
GROUP BY author_lname, author_fname
ORDER BY author_lname;

DROP TABLE books;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# JOINS

# Types of relationships:
# One to one, one to many, many to many
# Say we have book id per book -> that is a one to one relationship
# One book can have many pages -> that is a many to many relationship
# An author can write many books and a book can have many authors -> that is a many to many relationship

# One to many relationships
# Another example -> One NBA team has many players
# We start here because it is more used than one to one and is more applicable
# Customers and orders 
# One customer can place many orders and each order is associated with one user
# This is a one to many relationship
# We want to store
# 	first and last name
#	email
#	date of purchase
#	price of order
# We cam technicall do this with one giant table but this is not the best way to do it
# It would result in a lot of duplicate information
# It is more effective to create two separate tables
# Table 1 contains 
#	customer_id
#	first_name
#	last_name
#	email
# Table 2 contains
#	order_id
#	order_date
#	amount
#	customer_id
# In this case, the customer_id will be the PRIMARY KEY of table 1
# order_id will be the PRIMARY KEY of table 2, in table 2, customer_id is the FOREIGN key
# FOREIGN KEY enforces that these values entered exist in the PRIMARY KEY of the other table
CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(50)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
	amount decimal(8, 2),
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers(id)
)

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);


# CROSS JOINS
# Say we ran
SELECT * FROM customers, orders;
# This is called a CROSS JOIN or a CARTESIAN JOIN
# What this does is it takes every row from customers, individually, and associates it with every row in orders
# This results in a n x m table where n is the number of rows in table 1 and m table 2
# So in this example we end up with a 5x5 = 25 row table

# INNER JOINS
# How do we get get orders only associated with the correct customer?
# We can use a WHERE statement to set the condition
# IMPLICIT CODE
SELECT * FROM customers, orders
WHERE customers.id = orders.customer_id;
# We use the table name associated with the column name as a prefix
# We are joining the INTERSECTION between customers.id and orders.customer_id
# EXPLICIT CODE
SELECT * FROM customers
JOIN orders
	ON customers.id = orders.customer_id;
# We are EXPLICITLY saying to JOIN

SELECT first_name, last_name, SUM(amount) FROM customers
JOIN orders
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY SUM(amount) DESC;
# We can still do our normal operations on joined tables

# LEFT JOINS
# Left joins take everything from the first table and joins it with intersecting columns in the second table
# So in English
# When we left join the customers and orders table, ALL rows from customers will appear in the joined table
# Any rows in customers that also have corresponding data in orders will have the data filled in
# Anything in customers that does not have a much will have NULLs inputted
# Why would we want to do this? Say we wanted to list how much each user spent including those who have not spent ANYTHING
# From a business POV we can send a thank you email to high spenders and a coupon to people who haven't made a purchase yet
# We can replace NULL values with IFFNULL()
SELECT 
	first_name, 
	last_name, 
	IFNULL(SUM(amount), 0) AS 'Total Spent'
FROM customers
LEFT JOIN orders
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY 'Total Spent;'

# RIGHT JOIN
# Opposite of left join
SELECT 
	first_name, 
	last_name, 
	IFNULL(SUM(amount), 0) AS 'Total Spent'
FROM customers
RIGHT JOIN orders
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY 'Total Spent;'

# DELETE CASCADE
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
 
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE
);
 
 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

DELETE FROM customers WHERE email = 'george@gmail.com'
# Once the table is set up like this, deleting a row from customers will also delete corresponding entries in the orders table

# EXERCISE
CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100)
);

CREATE TABLE papers(
	title VARCHAR(100),
	grade INT,
	student_id INT,
	FOREIGN KEY(student_id)
		REFERENCES students(id)
		ON DELETE CASCADE
);

INSERT INTO students(first_name)
	VALUES 	('Caleb'),
			('Samantha'),
			('Raj'),
			('Carlos'),
			('Lisa')
;

INSERT INTO papers(student_id, title, grade) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94)
(2, 'De Montaigne And The Art Of The Essay', 98),
(4, 'Borges and Magical Realism', 89)

SELECT students.first_name, papers.title, papers.grade FROM students
JOIN papers
	ON students.id = papers.student_id
ORDER BY grade DESC;

SELECT students.first_name, IFNULL(papers.title, 'MISSING'), IFNULL(papers.grade, 0) FROM students
LEFT JOIN papers
	ON students.id = papers.student_id;

SELECT students.first_name, IFNULL(AVG(papers.grade), 0) as 'Average',
	CASE
		WHEN AVG(papers.grade) >= 75 THEN 'Passing'
		ELSE 'Failing'
	END AS 'passing_status'
FROM students
LEFT JOIN papers
	ON students.id = papers.student_id
GROUP BY first_name
ORDER BY AVG(papers.grade) DESC;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# MANY TO MANY JOINS
# More examples
# TV Shows < - > Reviews
# Students < - > Classes
# Instagram Posts < - > Tags
# Let's build a database that stores TV shows, reviewers and their reviews

CREATE TABLE reviewers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

CREATE TABLE reviews(
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

INSERT INTO series(title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO reviewers(first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1, 1, 8.0), (1, 2, 7.5), (1, 3, 8.5), (1, 4, 7.7), (1, 5, 8.9),
    (2, 1, 8.1), (2, 4, 6.0), (2, 3, 8.0), (2, 6, 8.4), (2, 5, 9.9),
    (3, 1, 7.0), (3, 6, 7.5), (3, 4, 8.0), (3, 3, 7.1), (3, 5, 8.0),
    (4, 1, 7.5), (4, 3, 7.8), (4, 4, 8.3), (4, 2, 7.6), (4, 5, 8.5),
    (5, 1, 9.5), (5, 3, 9.0), (5, 4, 9.1), (5, 2, 9.3), (5, 5, 9.9),
    (6, 2, 6.5), (6, 3, 7.8), (6, 4, 8.8), (6, 2, 8.4), (6, 5, 9.1),
    (7, 2, 9.1), (7, 5, 9.7),
    (8, 4, 8.5), (8, 2, 7.8), (8, 6, 8.8), (8, 5, 9.3),
    (9, 2, 5.5), (9, 3, 6.8), (9, 4, 5.8), (9, 6, 4.3), (9, 5, 4.5),
    (10, 5, 9.9),
    (13, 3, 8.0), (13, 4, 7.2),
    (14, 2, 8.5), (14, 3, 8.9), (14, 4, 8.9);

# Exercises
SELECT series.title, reviews.rating FROM series
JOIN reviews
	ON series.id = reviews.series_id
ORDER BY series.title;

SELECT series.title, AVG(reviews.rating) AS 'avg_rating' FROM series
JOIN reviews
	ON series.id = reviews.series_id
GROUP BY series_id
ORDER BY avg_rating;

SELECT reviewers.first_name, reviewers.last_name, reviews.rating FROM reviewers
JOIN reviews
	ON reviewers.id = reviews.reviewer_id;

SELECT series.title, reviews.rating FROM series
LEFT JOIN reviews
	ON series.id = reviews.series_id
WHERE reviews.rating IS NULL; 

SELECT series.genre, AVG(reviews.rating) AS 'Average Rating' FROM series
INNER JOIN reviews
	ON series.id = reviews.series_id
GROUP BY genre;

SELECT 
	first_name, 
	last_name, 
	COUNT(*) AS 'Count', 
	MIN(rating) AS 'Min', 
	MAX(rating) AS 'Max', 
	AVG(rating) AS 'Avg',
	CASE 
		WHEN MIN(rating) IS NULL THEN 'Inactive'
		ELSE 'ACTIVE'
	END AS 'Status'
FROM reviewers
LEFT JOIN reviews
	ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.first_name, reviewers.last_name;

SELECT title, rating, CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM reviews
INNER JOIN reviewers
	ON reviews.reviewer_id = reviewers.id
INNER JOIN series
	ON reviews.series_id = series.id
ORDER BY title;

###############################################################################################################################################################################################
###############################################################################################################################################################################################

# Instagram Schema Clone
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(100) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INT,
	FOREIGN KEY(id) REFERENCES users(id),
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(id),
	photo_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE likes(
	user_id INT,
	FOREIGN KEY(user_id) REFERENCES users(id),
	photo_id INT,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	created_at TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows(
	follower_id INT,
	followee_id INT,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(follower_id) REFERENCES users(id),
	FOREIGN KEY(followee_id) REFERENCES users(id),
	PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags(
	tag_name VARCHAR(255) UNIQUE,
	tag_id INT AUTO_INCREMENT PRIMARY KEY,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id, tag_id)
);

# After loading the provided data into the tables, we run some exercises
SELECT * FROM users
ORDER BY created_at ASC
LIMIT 5;

SELECT DAYNAME(created_at), COUNT(DAYNAME(created_at))
FROM USERS
GROUP BY DAYNAME(created_at)
ORDER BY DAYNAME(created_at);

SELECT username FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.user_id IS NULL;

SELECT photos.id, photos.image_url, Count(likes.user_id) as count
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
GROUP BY photos.id
ORDER BY count DESC;

SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

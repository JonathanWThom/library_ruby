# _Library Application_

#### _A web application to save Books, Authors, and Patrons. Exercise to practice many to many database relationships though use of SQL, Ruby, Sinatra; week three of Epicodus Ruby, 12/8/2016_

#### By _**Tracie Weitzman and Jonathan Thom**_

## Specifications

#### 1. Adds Books and Saves them to a Database
* Input: Harry Potter
* Output: Show link for book page

#### 2. Adds Authors and Saves them to a Database
* Input: JK Rowling
* Output: Success page, also appears in author list on book page

#### 3. Visit Book Page
* Input: check authors associated with Book
* Output: Authors appear as credited with Book

#### 4. Visit Patron page
* Input: add patron name
* Output: patron profile page created with link

#### 5. Patron Profile page allows user to check out a book
* Input: add book to checkout
* Output: book shows in a list of checked out books by patron

## Setup/Installation Requirements

_Works in any web browser. To run Library Application, in command line run:_

```
$ git clone https://github.com/weitzwoman/library_ruby
$ cd library_ruby
$ postgres
$ psql (optional, for editing the database directly)
$ bundle
$ ruby app.rb
```

_Add SQL Database_

```
CREATE DATABASE library;
\c library;
CREATE TABLE books (id serial PRIMARY KEY, title varchar);
CREATE TABLE patrons (id serial PRIMARY KEY, name varchar);
CREATE TABLE authors (id serial PRIMARY KEY, name varchar);
CREATE TABLE checkouts (id serial PRIMARY KEY, book_id int, patron_id int);
CREATE TABLE books_authors (id serial PRIMARY KEY, author_id int, book_id int);
```

## Support and contact details

_Contact us on Github at [weitzwoman](https://github.com/weitzwoman) and [JonathanWThom](https://github.com/JonathanWThom)_

## Technologies Used

* _HTML_
* _CSS_
  * _Bootstrap_
* _Ruby_
  * _Sinatra_
* _SQL_


### License

Library App is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Library App is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the Library App. If not, see http://www.gnu.org/licenses/.

Copyright (c) 2016 **_Tracie Weitzman and Jonathan Thom_**

require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/author')
require('./lib/patron')
require('pg')

#have this as test at first??
DB = PG.connect({:dbname => 'library'})

get('/') do
  @books = Book.all()
  erb(:index)
end

post('/add_book') do
  title = params.fetch('add_title')
  book = Book.new({:title => title, :id => nil})
  book.save()
  erb(:success)
end

post('/add_author') do
  name = params.fetch('name')
  author = Author.new({:name => name, :id => nil})
  author.save()
  erb(:success)
end

delete('/delete_book') do
  @book = Book.find(params.fetch('book_id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

post('/search_book') do
  title = params.fetch('title')
  @found_books = Book.search(title)
  erb(:search_book_page)
end

post('/search_author') do
  name = params.fetch('author')
  @found_authors = Author.search(name)
  erb(:search_author_page)
end

get('/patron') do
  @patrons = Patron.all()
  erb(:patron)
end

post('/add_patron') do
  name = params.fetch('name')
  patron = Patron.new({:name => name, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:patron)
end

get('/patron/:id') do
  @patron = Patron.find(params.fetch('id').to_i())
  @books = Book.all()
  erb(:individual_patron)
end

patch('/patron/:id') do
  patron_id = params.fetch('id').to_i()
  @patron = Patron.find(patron_id)
  book_ids = params.fetch('book_ids')
  book_ids.each() do |book_id|
    book = Book.find(book_id)
    @patron.checkout(book)
  end
  @patron.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:individual_patron)
end

get('/books/:id') do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all()
  erb(:individual_book)
end

patch('/books/:id') do
  book_id = params.fetch('id').to_i
  @book = Book.find(book_id)
  author_ids = params.fetch('author_ids')
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  erb(:individual_book)
end

#due_date = #time now plus 2 weeks or something like that
#use due date as a parameter when making a new checkout?

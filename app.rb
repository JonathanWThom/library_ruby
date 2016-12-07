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
  title = params.fetch('title')
  book = Book.new({:title => title, :id => nil})
  book.save()
  erb(:success)
end

delete('/delete_book') do
  @book = Book.find(params.fetch('book_id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:index)
end

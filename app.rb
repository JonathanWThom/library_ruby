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
  author = params.fetch('author')
  book = Book.new({:title => title, :author => author, :id => nil})
  book.save()
  erb(:success)
end

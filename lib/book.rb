class Book
  attr_reader(:title, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i()
      books.push(Book.new({:title => title, :id => id}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.id().==(another_book.id()).&(self.title().==(another_book.title()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |book_id|
    book_id_found = DB.exec("SELECT * FROM books WHERE id = '#{book_id}';").first()
    found_book = Book.new(:title => book_id_found.fetch('title'), :id => book_id_found.fetch('id').to_i())
    found_book
  end

  define_singleton_method(:search) do |searched_book|
    books = DB.exec("SELECT * FROM books WHERE title = '#{searched_book}';")
    found_books = []
    books.each() do |book|
      current_book = Book.new(:title => book.fetch('title'), :id => book.fetch('id').to_i())
      found_books.push(current_book)
    end
    found_books
  end
end

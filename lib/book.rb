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
    DB.exec("DELETE FROM authors_books WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM checkouts WHERE book_id = #{self.id()};")
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

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id()};")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
    end

    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{patron_id}, #{self.id()});")
    end
  end

  define_method(:authors) do
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
    results.each() do |result|
      author_id = result.fetch("author_id").to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first().fetch("name")
      book_authors.push(Author.new({:name => name, :id => author_id}))
    end
    book_authors
  end

  define_method(:patrons) do
    book_patrons = []
    results = DB.exec("SELECT patron_id FROM checkouts WHERE book_id = #{self.id()};")
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      book_patrons.push(Patron.new({:name => name, :id => patron_id}))
    end
    book_patrons
  end

end

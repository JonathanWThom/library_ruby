class Author
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i()
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_author|
    self.name().==(another_author.name()).&(self.id().==(another_author.id()))
  end

  define_singleton_method(:search) do |searched_author|
    authors = DB.exec("SELECT * FROM authors WHERE name = '#{searched_author}';")
    found_authors = []
    authors.each() do |author|
      current_author = Author.new(:name => author.fetch('name'), :id => author.fetch('id').to_i())
      found_authors.push(current_author)
    end
    found_authors
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  define_method(:books) do
    author_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author_books.push(Book.new({:title => title, :id => book_id}))
    end
    author_books
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE author_id = #{self.id()};")
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end
end

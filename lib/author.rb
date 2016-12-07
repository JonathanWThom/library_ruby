class Author
  attr_reader(:name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      authors.push(Author.new({:name => name}))
    end
    authors
  end

  define_method(:save) do
    DB.exec("INSERT INTO authors (name) VALUES ('#{@name}');")
  end

  define_method(:==) do |another_author|
    self.name().==(another_author.name())
  end
end

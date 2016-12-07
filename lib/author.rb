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
end

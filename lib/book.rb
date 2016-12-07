class Book
  attr_reader(:title, :author, :patron_id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @patron_id = attributes.fetch(:patron_id)
  end
end

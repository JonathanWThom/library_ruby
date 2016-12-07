class Patron
  attr_reader(:name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      patrons.push(Patron.new({:name => name}))
    end
    patrons
  end

  define_method(:save) do
    DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}');")
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name())
  end
end

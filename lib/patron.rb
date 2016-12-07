class Patron
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |patron_id|
    patron_id_found = DB.exec("SELECT * FROM patrons WHERE id = '#{patron_id}';").first()
    found_patron = Patron.new(:name => patron_id_found.fetch('name'), :id => patron_id_found.fetch('id').to_i())
    found_patron
  end
end

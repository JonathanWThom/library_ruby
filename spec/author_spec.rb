require('spec_helper')

describe(Author) do
  before() do
    @author = Author.new({:name => 'Alice Munro', :id => nil})
  end

  describe('#name') do
    it('returns the name of the author') do
      expect(@author.name()).to(eq('Alice Munro'))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      @author.save()
      expect(@author.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves author with name') do
      @author.save()
      expect(Author.all()).to(eq([@author]))
    end
  end

  describe('#==') do
    it('is the same author if the names of authors are the same text') do
      new_author = Author.new({:name => 'Alice Munro', :id => nil})
      expect(@author).to(eq(new_author))
    end
  end

  describe('.search') do
    it('returns an author name that you searched for') do
      @author.save()
      expect(Author.search(@author.name())).to(eq([@author]))
    end
  end

  describe("#update") do
    it('lets you update authors in the database') do
      author = Author.new({:name => "Herman Melville", :id => nil})
      author.save()
      author.update({:name => "Edith Wharton"})
      expect(author.name()).to(eq("Edith Wharton"))
    end
    it('lets you add a book to an author') do
      book = Book.new({:title => '10,000 Leagues Under the Sea', :id => nil})
      book.save()
      author = Author.new({:name => 'Jules Verne', :id => nil})
      author.save()
      author.update({:book_ids => [book.id()]})
      expect(author.books()).to(eq([book]))
    end
  end

  describe("#books") do
    it('returns all the books by an author') do
      book = Book.new({:title => '10,000 Leagues Under the Sea', :id => nil})
      book.save()
      book2 = Book.new({:title => 'Moby Dick', :id => nil})
      book2.save()
      author = Author.new({:name => 'Jules Verne', :id => nil})
      author.save()
      author.update(:book_ids => [book.id()])
      author.update(:book_ids => [book2.id()])
      expect(author.books()).to(eq([book, book2]))
    end
  end

  describe("#delete") do
    it('lets you delete an author from the database') do
      author = Author.new({:name => "Herman Melville", :id => nil})
      author.save()
      author2 = Author.new({:name => 'Jules Verne', :id => nil})
      author2.save()
      author.delete()
      expect(Author.all()).to(eq([author2]))
    end
  end
end

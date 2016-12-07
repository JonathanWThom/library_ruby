require('spec_helper')

describe(Book) do
  before() do
    @book = Book.new({:title => 'Harry Potter', :id => nil})
  end

  describe('#title') do
    it('returns the title of the book') do
      expect(@book.title()).to(eq('Harry Potter'))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      @book.save()
      expect(@book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves book with author and title') do
      @book.save()
      expect(Book.all()).to(eq([@book]))
    end
  end

  describe('#==') do
    it('is the same book if the titles and authors are the same text') do
      new_book = Book.new({:title => 'Harry Potter', :id => nil})
      expect(@book).to(eq(new_book))
    end
  end

  describe('#delete') do
    it('lets you delete a book in to database') do
      new_book = Book.new({:title => 'Harry Potter', :id => nil})
      new_book.save()
      @book.save()
      @book.delete()
      expect(Book.all()).to(eq([new_book]))
    end
  end

  describe('.find') do
    it('lets you find the book by id') do
      @book.save()
      expect(Book.find(@book.id())).to(eq(@book))
    end
  end

  describe('.search') do
    it('returns a book that you searched for') do
      @book.save()
      expect(Book.search(@book.title())).to(eq([@book]))
    end
  end

  describe("#update") do
    it("returns all of the authors of a particular book") do
      book = Book.new({:title => "Plainsong", :id => nil})
      book.save()
      author1 = Author.new({:name => "Smith", :id => nil})
      author1.save()
      author2 = Author.new({:name => "McPhee", :id => nil})
      author2.save()
      book.update({:author_ids => [author1.id(), author2.id()]})
      expect(book.authors()).to(eq([author1, author2]))
    end
  end

  describe("#authors") do
    it('returns all of the authors of a particular book') do
      book = Book.new({:title => "Plainsong", :id => nil})
      book.save()
      author1 = Author.new({:name => "Smith", :id => nil})
      author1.save()
      author2 = Author.new({:name => "McPhee", :id => nil})
      author2.save()
      book.update({:author_ids => [author1.id(), author2.id()]})
      expect(book.authors()).to(eq([author1, author2]))
    end
  end
end

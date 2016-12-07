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
    it('lets you delete a book inte database') do
      new_book = Book.new({:title => 'Harry Potter', :id => nil})
      new_book.save()
      @book.save()
      @book.delete()
      expect(Book.all()).to(eq([new_book]))
    end
  end
end

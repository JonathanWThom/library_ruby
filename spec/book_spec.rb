require('spec_helper')

describe(Book) do
  before() do
    @book = Book.new({:title => 'Harry Potter', :author => 'JK Rowling'})
  end

  describe('#title') do
    it('returns the title of the book') do
      expect(@book.title()).to(eq('Harry Potter'))
    end
  end

  describe('#author') do
    it('returns the author of the book') do
      expect(@book.author()).to(eq('JK Rowling'))
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
      new_book = Book.new({:title => 'Harry Potter', :author => 'JK Rowling'})
      new_book.save()
      @book.save()
      expect(@book).to(eq(new_book))
    end
  end
end

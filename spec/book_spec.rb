require('spec_helper')

describe(Book) do
  before() do
    @book = Book.new({:title => 'Harry Potter', :author => 'JK Rowling', :patron_id => 1})
  end

  describe('#title') do
    it('returns the title of the book') do
      expect(@book.title()).to(eq('Harry Potter'))
    end
  end
end

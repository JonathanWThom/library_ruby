require('spec_helper')

describe(Author) do
  before() do
    @author = Author.new({:name => 'Alice Munro'})
  end

  describe('#name') do
    it('returns the name of the author') do
      expect(@author.name()).to(eq('Alice Munro'))
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
      new_author = Author.new({:name => 'Alice Munro'})
      new_author.save()
      @author.save()
      expect(@author).to(eq(new_author))
    end
  end
end

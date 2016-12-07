require('spec_helper')

describe(Patron) do
  before() do
    @patron = Patron.new({:name => 'John Steinbeck'})
  end

  describe('#name') do
    it('returns the name of the patron') do
      expect(@patron.name()).to(eq('John Steinbeck'))
    end
  end

  describe('.all') do
    it('will be empty at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a patron with a name') do
      @patron.save()
      expect(Patron.all()).to(eq([@patron]))
    end
  end

  describe('#==') do
    it('is the same patron if they have the same name') do
      new_patron = Patron.new({:name => "John Steinbeck"})
      new_patron.save()
      @patron.save()
      expect(@patron).to(eq(new_patron))
    end
  end
end

require('spec_helper')

describe(Patron) do
  before() do
    @patron = Patron.new({:name => 'John Steinbeck', :id => nil})
  end

  describe('#name') do
    it('returns the name of the patron') do
      expect(@patron.name()).to(eq('John Steinbeck'))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      @patron.save()
      expect(@patron.id()).to(be_an_instance_of(Fixnum))
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
      new_patron = Patron.new({:name => "John Steinbeck", :id => nil})
      expect(@patron).to(eq(new_patron))
    end
  end

  describe('#delete') do
    it('lets you delete a patron in the database') do
      new_patron = Patron.new({:name => 'Upton Sinclair', :id => nil})
      new_patron.save()
      @patron.save()
      @patron.delete()
      expect(Patron.all()).to(eq([new_patron]))
    end
  end

  describe('#update') do
    it('lets you update a patron in the database') do
      @patron.save()
      @patron.update({:name => 'Upton Sinclair'})
      expect(@patron.name()).to(eq('Upton Sinclair'))
    end
  end

  describe('.find') do
    it('lets you find the patron by id') do
      @patron.save()
      expect(Patron.find(@patron.id())).to(eq(@patron))
    end
  end

end

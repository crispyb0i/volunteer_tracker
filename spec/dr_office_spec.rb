require("spec_helper")

describe(Doctor) do
  describe('#==') do
    it('returns true if doctor ids are the same') do
      dr1 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      dr2 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      expect(dr1).to(eq(dr2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Doctor.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a doctor to the database of saved doctors") do
      dr1 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      dr1.save()
      expect(Doctor.all()).to(eq([dr1]))
    end
  end

  describe('.find') do
    it('returns an object with a matching id to passed argument') do
      dr1 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      dr2 = Doctor.new({:id=>nil, :name=>'Bob', :spec=>'Pediatrics'})
      dr1.save
      dr2.save
      expect(Doctor.find(dr2.id)).to(eq(dr2))
    end
  end

end

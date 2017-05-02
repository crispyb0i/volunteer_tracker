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

  describe('#patients') do
    it('returns an array of all patients with dr_id equal to self.id') do
      dr1 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      dr1.save
      patient1 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => dr1.id})
      patient2 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => dr1.id})
      patient3 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => 0})
      patient1.save
      patient2.save
      patient3.save
      expect(dr1.patients).to(eq([patient1, patient2]))
    end
  end

  describe('.specs') do
    it('returns an object with a matching id to passed argument') do
      dr1 = Doctor.new({:id=>nil, :name=>'Steve', :spec=>'Pediatrics'})
      dr2 = Doctor.new({:id=>nil, :name=>'Bob', :spec=>'Oncology'})
      dr3 = Doctor.new({:id=>nil, :name=>'Bob', :spec=>'Pediatrics'})
      dr1.save
      dr2.save
      dr3.save
      expect(Doctor.specs('Pediatrics')).to(eq([dr1,dr3]))
    end
  end
end

require("spec_helper")

describe(Patient) do
  describe('#==') do
    it('returns true if patient ids are the same') do
      patient1 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => 1})
      patient2 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Patient.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the database of saved patients") do
      patient1 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => 1})
      patient1.save()
      expect(Patient.all()).to(eq([patient1]))
    end
  end

  describe("#dr_id") do
    it("lets you read the doctor ID out") do
      patient1 = Patient.new({:name=>'Steve', :birth=>'1/1/11', :dr_id => 1})
      expect(patient1.dr_id).to(eq(1))
    end
  end
end

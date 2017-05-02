require("rspec")
require("pg")
require("dr_office")

DB = PG.connect({:dbname => 'doctors_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

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
end

describe(Patient) do
end

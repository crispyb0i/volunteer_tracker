require("spec_helper")

describe(Volunteer) do
  describe('#==') do
    it('returns true if volunteer ids are the same') do
      volunteer1 = Volunteer.new({:name=>'Steve', :project_id => 1})
      volunteer2 = Volunteer.new({:name=>'Steve', :project_id => 1})
      expect(volunteer1).to(eq(volunteer2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Volunteer.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a volunteer to the database of saved volunteers") do
      volunteer1 = Volunteer.new({:name=>'Steve', :project_id => 1})
      volunteer1.save()
      expect(Volunteer.all()).to(eq([volunteer1]))
    end
  end

  # describe("#project_id") do
  #   it("lets you read the doctor ID out") do
  #     volunteer1 = Volunteer.new({:name=>'Steve', :birth=>'1/1/11', :project_id => 1})
  #     expect(volunteer1.project_id).to(eq(1))
  #   end
  # end
end

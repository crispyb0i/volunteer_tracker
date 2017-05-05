require("spec_helper")

describe(Project) do
  describe('#==') do
    it('returns true if project ids are the same') do
      pr1 = Project.new({:id=>nil, :name=>'Dark Hole'})
      pr2 = Project.new({:id=>nil, :name=>'Dark Hole'})
      expect(pr1).to(eq(pr2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Project.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a project to the database of saved projects") do
      pr1 = Project.new({:id=>nil, :name=>'Steve'})
      pr1.save()
      expect(Project.all()).to(eq([pr1]))
    end
  end

  describe('.find') do
    it('returns an object with a matching id to passed argument') do
      pr1 = Project.new({:id=>nil, :name=>'Dark Hole'})
      pr2 = Project.new({:id=>nil, :name=>'Hulk'})
      pr1.save
      pr2.save
      expect(Project.find(pr2.id)).to(eq(pr2))
    end
  end

  describe('#volunteers') do
    it('returns an array of all patients with project_id equal to self.id') do
      pr1 = Project.new({:id=>nil, :name=>'Dark hole'})
      pr1.save
      volunteer1 = Volunteer.new({:name=>'Steve', :project_id => pr1.id.to_i})
      volunteer2 = Volunteer.new({:name=>'Steve', :project_id => pr1.id.to_i})
      volunteer3 = Volunteer.new({:name=>'Steve', :project_id => 0})
      volunteer1.save
      volunteer2.save
      volunteer3.save
      expect(pr1.volunteers).to(eq([volunteer1, volunteer2]))
    end
  end

end

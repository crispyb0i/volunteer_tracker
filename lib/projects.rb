class Project
  attr_accessor(:id, :name)
  define_method(:initialize) do |attrib|
    @id = attrib[:id]
    @name = attrib[:name]
  end

  define_method(:==) do |project2|
    self.id == project2.id
  end

  define_singleton_method(:all) do
    all_projects = []
    returned_projects = DB.exec('SELECT * FROM projects')
    returned_projects.each() do |project|
      id = project["id"].to_i
      name = project["name"]
      dr_rm = Project.new({:id=>id,:name=>name})
      all_projects.push(dr_rm)
    end
    all_projects
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  define_singleton_method(:find) do |id|
    found = nil
    Project.all.each() do |project|
      if project.id == id
        found = project
      end
    end
    found
  end

  define_method(:volunteers) do
    project_volunteers = []
    Volunteer.all.each() do |volunteer|
      if volunteer.project_id==self.id
        project_volunteers.push(volunteer)
      end
    end
    project_volunteers
  end

  define_method(:update) do |attrib|
    @name = attrib.fetch(:name)
    DB.exec("UPDATE projects SET name='#{@name}' WHERE id='#{self.id}'")
  end
end

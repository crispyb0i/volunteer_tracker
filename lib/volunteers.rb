class Volunteer
  attr_accessor(:id, :name, :project_id)
  define_method(:initialize) do |attrib|
    @id = attrib[:id]
    @name = attrib[:name]
    @project_id = attrib[:project_id].to_i
  end

  define_method(:==) do |volunteer2|
    self.id == volunteer2.id
  end

  define_singleton_method(:all) do
    all_volunteers = []
    returned_volunteers = DB.exec('SELECT * FROM volunteers')
    returned_volunteers.each() do |volunteer|
      id = volunteer["id"].to_i
      name = volunteer["name"]
      project_id = volunteer["project_id"]
      volunteer_rm = Volunteer.new({:id=>id,:name=>name,:project_id => project_id})
      all_volunteers.push(volunteer_rm)
    end
    all_volunteers
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}','#{@project_id}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  define_singleton_method(:find) do |id|
    found = nil
    Volunteer.all.each() do |volunteer|
      if volunteer.id == id
        found = volunteer
      end
    end
    found
  end

  define_method(:update) do |attrib|
    @name = attrib.fetch(:name)
    DB.exec("UPDATE volunteers SET name='#{@name}' WHERE id='#{self.id}'")
  end


  define_method(:delete) do
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end

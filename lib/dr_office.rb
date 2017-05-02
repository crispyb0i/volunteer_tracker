class Doctor
  attr_accessor(:id, :name, :specialty)
  define_method(:initialize) do |attrib|
    @id = attrib[:id]
    @name = attrib[:name]
    @spec = attrib[:spec]
    #add to database
  end

  #@@doctors = []

  define_method(:==) do |dr2|
    self.id == dr2.id
  end

  define_singleton_method(:all) do
    all_doctors = []
    returned_doctors = DB.exec('SELECT * FROM doctors')
    returned_doctors.each() do |doctor|
      id = doctor[:id]
      name = doctor[:name]
      spec = doctor[:spec]
      all_doctors.push(Doctor.new({:id=>id,:name=>name,:spec=>spec}))
    end
    all_doctors
  end

  define_method(:save) do
    DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}','#{@spec}');")
  end

  define_method(:add_patient) do |patient|
    #patient.dr_id = @id
  end

  define_method(:find) do |id|
    found = nil
    returned_doctors = DB.exec('SELECT * FROM doctors')
    returned_doctors.each() do |doctor|
      if doctor.id == id
        found = doctor
      end
    end
    found
  end
end

class Patient
  attr_accessor(:id, :name, :birth, :dr_id)
  define_method(:initialize) do |attrib|
    @id = attrib[:id]
    @name = attrib[:name]
    @birth = attrib[:birth]
    @dr_id = attrib[:dr_id]
  end
end

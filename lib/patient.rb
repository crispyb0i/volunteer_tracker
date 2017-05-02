class Patient
  attr_accessor(:name, :birth, :dr_id)
  define_method(:initialize) do |attrib|
    @name = attrib[:name]
    @birth = attrib[:birth]
    @dr_id = attrib[:dr_id]
  end

  define_method(:==) do |patient2|
    self.name == patient2.name
  end

  define_singleton_method(:all) do
    all_patients = []
    returned_patients = DB.exec('SELECT * FROM patients')
    returned_patients.each() do |patient|
      name = patient["name"]
      birth = patient["birth_date"]
      dr_id = patient["doctor_id"].to_i
      patient_rm = Patient.new({:name=>name,:birth=>birth, :dr_id=>dr_id})
      all_patients.push(patient_rm)
    end
    all_patients
  end

  define_method(:save) do
    DB.exec("INSERT INTO patients (name, birth_date, doctor_id) VALUES ('#{@name}','#{@birth}','#{@dr_id}');")
  end

  define_method(:add_doctor) do |patient|
    #patient.dr_id = @id
  end
end

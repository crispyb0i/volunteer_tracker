require('sinatra')
require('sinatra/reloader')
require('./lib/dr_office')
require('./lib/Patient')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'doctors'})

get('/') do
  @doctors = Doctor.all
  erb(:index)
end

post('/') do
  dr_name = params.fetch('name')
  dr_specialty = params.fetch('specialty')
  new_doctor = Doctor.new({:id => nil, :name => dr_name, :spec => dr_specialty})
  new_doctor.save
  @doctors = Doctor.all
  erb(:index)
end

get('/:id') do
  @doctor = Doctor.find(params[:id].to_i)
  @patients = Patient.all
  erb(:patients)
end

post('/:id') do
  @doctor = Doctor.find(params[:id].to_i)
  patient_name = params.fetch('name')
  patient_birth = params.fetch('birth')
  new_patient = Patient.new({:name => patient_name, :birth => patient_birth, :dr_id=>@doctor.id})
  new_patient.save
  @patients = Patient.all
  erb(:patients)
end

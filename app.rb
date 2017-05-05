require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  project_name = params.fetch('name')
  new_project = Project.new({:id => nil, :name => project_name})
  new_project.save
  @projects = Project.all
  erb(:index)
end

get('/:id') do
  @project = Project.find(params[:id].to_i)
  @patients = Volunteer.all
  erb(:patients)
end

post('/:id') do
  @project = Project.find(params[:id].to_i)
  patient_name = params.fetch('name')
  patient_birth = params.fetch('birth')
  new_patient = Volunteer.new({:name => patient_name, :birth => patient_birth, :project_id=>@project.id})
  new_patient.save
  @patients = Volunteer.all
  erb(:patients)
end

patch('/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({:name=>params[:update_name], :specialty=>params[:update_specialty]})
  erb(:patients)
end

delete('/:id') do
  @project = Project.find(params[:id].to_i)
  @patients = Volunteer.all
  DB.exec("DELETE FROM patients WHERE name = #{params[:patient_id]};")
  erb(:patients)
end

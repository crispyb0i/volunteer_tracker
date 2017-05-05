require('sinatra')
require('sinatra/reloader')
require('./lib/projects')
require('./lib/volunteers')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  project_name = params.fetch('project_name')
  new_project = Project.new({:id => nil, :name => project_name})
  new_project.save
  @projects = Project.all
  erb(:index)
end

get('/:id') do
  @project = Project.find(params[:id].to_i)
  @volunteers = Volunteer.all
  erb(:volunteers)
end

post('/:id') do
  @project = Project.find(params[:id].to_i)
  volunteer_name = params.fetch('name')
  new_volunteer = Volunteer.new({:name => volunteer_name, :project_id => @project.id})
  new_volunteer.save
  @volunteers = Volunteer.all
  binding.pry
  erb(:volunteers)
end

patch('/:id') do
  @volunteers = Volunteer.all
  @project = Project.find(params[:id].to_i)
  @project.update({:name=>params[:update_name]})
  erb(:volunteers)
end

delete('/:id') do
  @project = Project.find(params[:id].to_i)
  @volunteers = Volunteer.all
  id = params.fetch("delete_name")
  @volunteer =  Volunteer.find(id)
  DB.exec("DELETE FROM volunteers WHERE id = #{id};")
  erb(:volunteers)
end

delete ('/projects/:id') do
  id = params.fetch("id").to_i()
  @project = Project.find(id)
  DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  @projects = Project.all()
  erb(:volunteers)
end

require('sinatra')
require('sinatra/reloader')
require('./lib/projects')
require('./lib/volunteers')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'volunteer_tracker'})
# DB.exec("DELETE FROM projects *;")
# DB.exec("DELETE FROM volunteers *;")

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

delete ('/') do
  id = params.fetch("delete_project").to_i()
  @project = Project.find(id)
  DB.exec("DELETE FROM projects WHERE id = #{id};")
  @projects = Project.all()
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
  new_volunteer = Volunteer.new({:id => nil, :name => volunteer_name, :project_id => @project.id})
  @volunteers = Volunteer.all
  new_volunteer.save
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
  id_yes = params[:delete_name]
  @volunteer =  Volunteer.find(id)
  DB.exec("DELETE FROM volunteers WHERE id = #{id_yes};")
  erb(:volunteers)
end

delete ('/projects/:id') do
  id = params.fetch("id").to_i()
  @project = Project.find(id)
  DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  @projects = Project.all()
  erb(:volunteers)
end

get ('/volunteer/:id') do
  @project = Project.find(params[:id].to_i)
  @volunteer = Volunteer.find(params[:id].to_i)
    @projects = Project.all
  erb(:update_volunteer_name)
end

patch ('/volunteer/:id') do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.update({:name=>params[:update_name]})
  @projects = Project.all
  @project = Project.find(params[:id].to_i)
  erb(:index)
end

post ('/volunteer/:id') do
  @volunteers = Volunteer.all
  @project = Project.find(params[:id].to_i)
  erb(:index)
end

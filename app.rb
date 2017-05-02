require('sinatra')
require('sinatra/reloader')
require('./lib/dr_office')
require('pry')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'doctors'})

get('/') do
  erb(:index)
end

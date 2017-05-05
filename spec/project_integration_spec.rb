require('spec_helper')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('add and update a new project', {:type => :feature}) do
  it('allows user to "Add Project" to create a new project') do
    visit('/')
    fill_in('project_name', :with =>'BOOM')
    click_button('Add a project!')
    expect(page).to have_content('List of current projects BOOM Add a new project New Project Name Add a project! Delete a project BOOM Remove project')
  end
end

describe('add and update a new volunteer', {:type => :feature}) do
  it('allows user to "Add a volunteer" to the list of volunteers') do
    visit('/1')
    fill_in('name', :with =>'Harry')
    click_button('Add a Volunteer!')
    expect(page).to have_content('Harry')
  end
end

# Volunteer Tacker
#### By David Shin

## This is a website that allows you to track volunteers and projects
* Allows to add, view, update and delete projects
* Allows to add, view, update and delete volunteers
* Allows to assign volunteers to projects

## Setup
* Make sure you have Postgres installed: https://www.learnhowtoprogram.com/ruby/ruby-database-basics/installing-postgres-7fb0cff7-a0f5-4b61-a0db-8a928b9f67ef
* Open a terminal and run $ psql.
* Create volunteer_tracker database - CREATE DATABASE volunteer_tracker;
* Connect to database - \c volunteer_tracker;
* Create tables -
CREATE TABLE projects (id serial PRIMARY KEY, name varchar, info varchar);
CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar);
CREATE TABLE assignments (volunteer_id integer, project_id integer, );
* Clone this repository https://github.com/ahorod/volunteer_tracker
* Run bundle in Terminal window
* Run ruby app.rb in Terminal
* Open on localhost:4567 in browser

## Technologies Used
* HTML
* Ruby
* Postgres SQL

## Known Bugs

_{N/A}_

## Support and contact details

_{If you run into any issues, please contact Epicodus}_

## Technologies Used

_{Created using HTML, CSS, Bootstrap, Ruby and Sinatra.}_

### License

*Copyright (c) 2017 **_{Epicodus}_***

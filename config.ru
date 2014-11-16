require 'bundler'
Bundler.require

use ActiveRecord::ConnectionAdapters::ConnectionManagement 


require './controllers/application_controller.rb'
require './controllers/entries_controller.rb'
require './controllers/sessions_controller.rb'
require './controllers/tags_controller.rb'
require './controllers/users_controller.rb'

require './models/entry.rb'
require './models/tag.rb'
require './models/user.rb'

require './helpers/authentication_helper.rb'


map('/tags'){ run TagsController }

map('/entries'){ run EntriesController }

map('/users'){ run UsersController }

map('/sessions'){ run SessionsController }

map('/'){ run ApplicationController }


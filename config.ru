require 'bundler'
Bundler.require

use ActiveRecord::ConnectionAdapters::ConnectionManagement 


require './controllers/application_controller'
require './controllers/entries_controller'
require './controllers/sessions_controller'
require './controllers/tags_controller'
require './controllers/users_controller'

require './models/entry'
require './models/tag'
require './models/user'

require './helpers/authentication_helper'


map('/tags'){ run TagsController }

map('/entries'){ run EntriesController }

map('/users'){ run UsersController }

map('/sessions'){ run SessionsController }

map('/'){ run ApplicationController }


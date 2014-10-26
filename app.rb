require 'bundler'
Bundler.require

### CONNECTION ###
require_relative 'connection.rb'

### MODELS ###
require_relative 'models/entry'
require_relative 'models/user'

### HELPERS ###
require './helpers/application_helper'

### SESSIONS ###
enable :sessions

### LANDING PAGE ###

get '/' do
  @entries = Entry.all
  erb :index
end

### USERS ###
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  @user.password = params[:password]

  if @user.valid?
    @user.save!
    redirect '/sessions/new'
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end

end

### SESSIONS ###

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  redirect '/' unless user = User.find_by({username: params[:username]})
  if user.password == params[:password]
    session[:current_user] = user.id
    redirect '/entries'
  else
    redirect '/sessions/new'
  end
end

delete '/sessions' do
  session[:current_user] = nil
  redirect '/'
end

### ENTRIES CRUD ###

get '/entries' do
  @entries = Entry.all
  erb :'entries/index'
end

get '/entries/new' do
  erb :'entries/new'
end

post '/entries' do
  entry = Entry.create(params[:entry])
  redirect '/entries'
end

get '/entries/:id/edit' do
  @entry = Entry.find(params[:id])

  erb :'/entries/edit'
end

patch '/entries/:id' do
  authenticate_admin!
  entry = Entry.find(params[:id])
  entry.update(params[:entry])
  redirect '/entries/#{entry.id}'
end

get '/entries/:id' do
  @entry = Entry.find(params[:id])
  @user = current_user

  begin
    @user.authenticate_admin
  rescue User::AuthenticateAdmin => e
    @error = e
  end

  erb :'entries/show'
end

delete '/entries/:id' do
  authenticate_admin!
  Entry.delete(params[:id])
  redirect '/entries'
end
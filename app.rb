require 'bundler'
Bundler.require

### CONNECTION ###
require_relative 'connection.rb'

### CONNECTION ###
require_relative 'models/entry'
require_relative 'models/user'

### SESSIONS ###
enable :sessions

### LANDING PAGE ###

get '/' do
  @entries = Entry.all
  erb :index
end


### SESSIONS ###

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user = User.find_by({username: params[:username]})
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
  if session[:current_user]
    @user = User.find(session[:current_user])
    @entry = Entry.find(params[:id])
    erb :'entries/edit'
  else
    redirect '/sessions/new'
  end
end

patch '/entries/:id' do
  entry = Entry.find(params[:id])
  entry.update(params[:entry])
  redirect '/entries/#{entry.id}'
end

get '/entries/:id' do
  @entry = Entry.find(params[:id])
  erb :'entries/show'
end

delete '/entries/:id' do
  if session[:current_user]
    @user = User.find(session[:current_user])
    entry = Entry.destroy(params[:id])
    redirect '/entries'
  else
    redirect '/sessions/new'
  end
end
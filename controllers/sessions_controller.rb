class SessionsController < ApplicationController
  # helpers Sinatra::AuthenticationHelper

  # ActiveRecord::Base.establish_connection({
  #   adapter: 'postgresql',
  #   database: 'blog_db'
  # })

  # set :views, File.expand_path('../../views',__FILE__)

  # set :public_folder, File.expand_path('../../public',__FILE__)

  # enable :sessions, :method_override

  ###ROUTES###

  get '/new' do
    erb :'sessions/new'
  end

  post '/' do
    redirect '/' unless user = User.find_by({username: params[:username]})
    if user.password == params[:password]
      session[:current_user] = user.id
      redirect '/entries'
    else
      redirect '/sessions/new'
    end
  end

  delete '/' do
    session[:current_user] = nil
    redirect '/'
  end

end
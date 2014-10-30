class SessionsController < ApplicationController


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
class UsersController < ApplicationController
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
    erb :'users/new'
  end

  post '/' do
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

end
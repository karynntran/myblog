class EntriesController < ApplicationController
  # helpers Sinatra::AuthenticationHelper

  # ActiveRecord::Base.establish_connection({
  #   adapter: 'postgresql',
  #   database: 'blog_db'
  # })

  # set :views, File.expand_path('../../views',__FILE__)

  # set :public_folder, File.expand_path('../../public',__FILE__)

  # enable :sessions, :method_override

  ###ROUTES###

  get '/' do
    current_user
    @entries = Entry.all
    @sorted_entries = @entries.sort_by { |entry| entry[:id] }.reverse!

    erb :'entries/index'
  end

  get '/new' do
    if current_user
      erb :'entries/new'
    else
      redirect '/users/new'
    end
  end

  post '/' do
    entry = Entry.create(params[:entry])
    redirect '/entries'
  end

  get '/:id/edit' do
    @entry = Entry.find(params[:id])

    erb :'/entries/edit'
  end

  patch '/:id' do
    entry = Entry.find(params[:id])
    entry.update(params[:entry])
    redirect '/entries/#{entry.id}'
  end

  get '/:id' do
    user = current_user
    @entry = Entry.find(params[:id])

    begin
      user.admin_error
    rescue User::AuthenticateAdmin => e
      @error = e
    end

    erb :'entries/show'
  end

  delete '/:id' do
    Entry.delete(params[:id])
    redirect '/entries'
  end

end
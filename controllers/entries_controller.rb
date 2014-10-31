class EntriesController < ApplicationController

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
    entry.tags << Tag.create(params[:tag])
    redirect '/entries'
  end

  get '/:id/edit' do
    @entry = Entry.find(params[:id])

    erb :'/entries/edit'
  end

  patch '/:id' do
    entry = Entry.find(params[:id])
    entry.update(params[:entry])

    tag = Tag.find(params[:id])
    tag.update(params[:tag])
    redirect '/entries/#{entry.id}'
  end

  get '/:id' do
    user = current_user
    @entry = Entry.find(params[:id])
    @tag = Tag.where(entry_id: params[:id])

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
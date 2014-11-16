class EntriesController < ApplicationController

  get '/' do
    current_user
    @entries = Entry.all

    @sorted_entries = @entries.sort_by { |entry| entry[:id] }.reverse!
    @featured_post = @sorted_entries[0]
    @featured_post_spacing = @featured_post.post.gsub("*","<br><br>")

  erb :'entries', :layout => false

  end

  get '/new' do

    if current_user
      erb :'entries/new'
    else
      redirect '/users/new'
    end
  end

  post '/' do

    params[:entry][:post].gsub!("\r\n","*")

    entry = Entry.create(params[:entry])

    tag_string = params[:tag][:body].split(/\s|,\s|\s|,/)

    tag_string.each do |tag|
      each_tag = Tag.create(body: tag)
      entry.tags << each_tag
    end

    redirect '/entries'
  end

  get '/:id/edit' do

    @entry = Entry.find(params[:id])
    @post = @entry.post.gsub("*","\r\n")
    @tags = @entry.tags
    erb :'/entries/edit'
  end

  patch '/:id' do
    entry = Entry.find(params[:id])
    entry.update(params[:entry])

    tags = entry.tags
    tags.each do |tag|
      tag.update(params[:tags])
    end

    redirect '/entries/#{entry.id}'
  end

  get '/:id' do
    user = current_user

    @entry = Entry.find(params[:id])
    @post = @entry.post.gsub("*","<br><br>")
    @tags = @entry.tags



    begin
      user.admin_error
    rescue User::AuthenticateAdmin => e
      @error = e
    end

    erb :'entries/show'
  end

##DELETE ENTRIES##
  delete '/:id' do
    Entry.delete(params[:id])
    redirect '/entries'
  end


end
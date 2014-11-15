class TagsController < ApplicationController

  get '/' do
  	@tags = Tag.all
  	erb :'tags/index'
  end

  # get '/new' do
  #   if current_user
  #     erb :'tags/new'
  #   else
  #     redirect '/users/new'
  #   end
  # end

  # post '/' do
  #   tag_string = params[:tag][:body].split(/\s|,\s|\s|,/)

  #   tag_string.each do |tag|
  #     each_tag = Tag.create(body: tag)
  #   entry.tags << each_tag
  # end


  delete '/:id' do

    Tag.destroy(params[:id])
    redirect '/entries'
  end

end
class TagsController < ApplicationController

  get '/' do
  	@tags = Tag.all
  	erb :'tags/index'
  end


  delete '/:id' do
    tag = Tag.find(params[:id])
    entry = tag.entries[0].id
    Tag.destroy(params[:id])
    redirect '/entries/#{entry}'

  end

end
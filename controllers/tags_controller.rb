class TagsController < ApplicationController

  get '/' do
  	@tags = Tag.all
  	erb :'tags/index'
  end


  delete '/:id' do
    binding.pry
    entry = Entry.where(tag_id: params[:id])
    Tag.destroy(params[:id])
    redirect '/entries'
  end

end
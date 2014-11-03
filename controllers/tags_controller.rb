class TagsController < ApplicationController

  get '/' do
  	@tags = Tag.all
  	erb :'tags/index'
  end


  delete '/:id' do

    # entry = Entry.includes(:tags).where(tags: { id: params[:id] })
    # entry_url = entry[0].id
    # entry = Entry.where(tad_id: params[:id])
    Tag.destroy(params[:id])
    redirect '/entries'
  end

end
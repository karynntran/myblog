class TagsController < ApplicationController

  get '/' do
  	@tags = Tag.all
  	erb :'tags/index'
  end

end
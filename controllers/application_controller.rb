class ApplicationController < Sinatra::Base
  helpers Sinatra::AuthenticationHelper
  helpers ActiveSupport::Inflector

  set :views, File.expand_path('../../views',__FILE__)

  set :public_folder, File.expand_path('../../public',__FILE__)

  enable :sessions, :method_override

  ###ROUTES###

  get '/' do
    @entries = Entry.all
    erb :index, :layout => false
  end

  get '/aboutme' do
    erb :'users/aboutme'
  end

end
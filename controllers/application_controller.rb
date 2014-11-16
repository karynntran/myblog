class ApplicationController < Sinatra::Base
  helpers Sinatra::AuthenticationHelper
  helpers ActiveSupport::Inflector

  ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    database: 'blog_db'
  })

  set :views, File.expand_path('../../views',__FILE__)

  set :public_folder, File.expand_path('../../public',__FILE__)

  enable :sessions, :method_override

  register Sinatra::ActiveRecordExtension

  ###ROUTES###

  get '/' do
    @entries = Entry.all
    erb :index, :layout => false
  end

  get '/aboutme' do
    erb :'users/aboutme'
  end

end
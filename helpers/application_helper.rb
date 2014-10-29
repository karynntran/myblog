module Sinatra
  module AuthenticationHelper

    def current_user
      if session[:current_user]
        @current_user ||= User.find(session[:current_user])
      else
        nil
      end
    end

    def authenticate
      redirect '/sessions/new' unless current_user
    end

    def authenticate_admin!
      redirect '/' unless current_user.username == "karynn"
    end

  end

end
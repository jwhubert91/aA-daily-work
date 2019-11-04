class ApplicationController < ActionController::Base

    def current_user
        user = User.find(session[:session_token])
    end


end

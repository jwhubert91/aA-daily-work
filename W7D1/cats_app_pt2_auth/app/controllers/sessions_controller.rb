class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:username],params[:password])

        if user
            session[:session_token] = user.reset_session_token!
            flash[:success] = "Success! You're logged in!"
            redirect_to cats_url
        else
            render :new, status: 422
        end
    end

    def destroy
        
    end

end
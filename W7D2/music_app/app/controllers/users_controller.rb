
class UsersController < ApplicationController

    def create
        # the create action will take in sign up data given by the user and then
        # direct the user to a logged-in-successfully view
        @user = User.new(user_params)

        if @user.save
            render plain: "logged in successfully"
        else
            render json: @user.errors.full_messages
        end
    end

    def new
        # the new action will instantiate a new user and lead to the login view
        @user = User.new
    end

    private
    def user_params
        params.require(:user).permit(:email,:password)
    end
end
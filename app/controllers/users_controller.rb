class UsersController < ApplicationController

    #skip_before_action :require_login, only: [:new, :create]

    def index
    end

    def show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            flash[:error] = "There was an error while creating your account. Please try again."
            redirect_to new_user_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end

end

class UsersController < ApplicationController

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
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def destroy
        user = User.find(session[:user_id])
        session[:user_id] = nil
        user.destroy
        flash[:notices] = ["You have successfully deleted your account."]
        redirect_to '/'
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end

end
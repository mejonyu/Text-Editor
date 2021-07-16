class SessionsController < ApplicationController

    def new
    end

    def create
        session_params = params.permit(:username, :password)
        @user = User.find_by(username: session_params[:username])
        
        if @user && @user.authenticate(session_params[:password])
            session[:user_id] = @user.id
            redirect_to @user
        else
            flash[:errors] = ["Login is invalid."]
            redirect_to signin_path
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notices] = ["You have been signed out."]
        redirect_to '/'
    end

end
class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by_username(params[:user][:username])
  
      if @user && @user.authenticate(params[:user][:password])
        flash[:message] = "Successfully signed in"
        session[:user_id] = @user.id
        redirect_to images_path
      else
        flash[:message] = "Invalid credentials"
        render :new
      end
    end
  
    def destroy
      # session[:user_id] = nil
      # session.delete(:user_id)
      session.clear
      redirect_to signin_path
    end
  end

class EssaysController < ApplicationController
    def index
        @user= User.find(params[:user_id])
        @essays = @user.essays
        
    end

    def show
        @essay = Essay.find(params[:id])
    end

end

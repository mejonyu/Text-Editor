module ApplicationHelper
    def current_user
      @user = User.find_by_id(session[:user_id])
    end
  
    # !!nil -> !true -> false
    # !!user_instance -> !false -> true
    def signed_in?
      !!current_user
    end
  end

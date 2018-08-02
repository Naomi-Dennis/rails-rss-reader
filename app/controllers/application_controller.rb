class ApplicationController < ActionController::Base

    def isLoggedIn?
        !session.nil?
    end
    
    def getLoggedUser
       if isLoggedIn?
         User.find_by(id: session[:id])
       else
         nil
       end
    end

    def logout_user 
        session.clear 
    end 

    def authenticate_user 
        @current_user = getLoggedUser
        @isLoggedIn = isLoggedIn?
        unless @current_user
            redirect_to login_user_url 
            return 
        end 
    end 

end

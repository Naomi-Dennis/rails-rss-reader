module SessionHelper 
    
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

end 
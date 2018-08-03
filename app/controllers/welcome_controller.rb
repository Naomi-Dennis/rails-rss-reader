class WelcomeController < ApplicationController 
    before_action :authenticate_user 
    def index 
        @isLoggedIn = isLoggedIn?
        Feed.updateAllFeeds
    end 

 
end 
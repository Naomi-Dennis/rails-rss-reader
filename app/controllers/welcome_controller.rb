class WelcomeController < ApplicationController 
    before_action :authenticate_user 
    def index 
        @isLoggedIn = isLoggedIn?
        Feed.updateAllFeeds
        @feeds = getLoggedUser.feeds
        @articlesByDate = { }
        @feeds.each do | feed | 
            @articles = feed.articles 
            @articlesByDate = Hash.new
            @articlesByDate[feed.name] = Hash.new
            i = 0
            while i < 7 do
             date = (DateTime.now - i).strftime("%B %d, %Y")
             queriedArticles = Article.where(date: date).select(:title, :description)
             if date ==  (DateTime.now).strftime("%B %d, %Y")
                 date = "Today"
                else    
                 date = (DateTime.now - i).strftime("%A %B %d, %Y")
             end
             @articlesByDate[feed.name][date] = queriedArticles unless queriedArticles.nil? || queriedArticles.empty? 
             i += 1
          end
        end 
    end 


 
end 
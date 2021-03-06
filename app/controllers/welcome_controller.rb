class WelcomeController < ApplicationController 
    before_action :authenticate_user 
    def index 
        @isLoggedIn = isLoggedIn?
        Feed.updateAllFeeds
        @feeds = getLoggedUser.feeds
        @articlesByDate = { }
        @date = DateTime.now.strftime("%B %d, %Y")
        @feeds.each do | feed | 
            queriedArticles = feed.articles.where(date: @date)
            unless queriedArticles.nil? || queriedArticles.empty?
              @articlesByDate[feed] = Hash.new
              @articlesByDate[feed] = queriedArticles
            end
        end 
        @feeds = @feeds.sort{ |a,b| (a.url < b.url) ? -1 : ( (a.url > b.url) ? 1 : 0  ) }
    end 


 
end 
class User < ActiveRecord::Base
    has_secure_password
    
    ## relationships 
    has_many :user_feed
    has_many :feeds, through: :user_feed
    
    ## instance functions 
    def updateFeeds
      feeds.each do | feed |
        feed.updateFeed
      end
    end

   
end
  
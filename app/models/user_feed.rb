class UserFeed < ActiveRecord::Base
    ## relatioships 
    belongs_to :user
    belongs_to :feed
end
  
class Article < ActiveRecord::Base
    ## relationships 
    belongs_to :feed
  end
  
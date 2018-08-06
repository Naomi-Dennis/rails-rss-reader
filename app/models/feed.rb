require 'open-uri'
require "net/http"
require 'rss'
class Feed < ActiveRecord::Base
  ## relationships 
  has_many :user_feed
  has_many :users, through: :user_feed

  has_many :articles, dependent: :destroy

  ## class functions 
  def self.updateAllFeeds 
    Feed.all.map{ |feed| feed.updateFeed }
  end 
  ## instance functions
  def isFeedUpdated? 
    data = open(url)
    feed = RSS::Parser.parse(data, false)
    feed.channel.items.first.date.strftime("%B %d, %Y") == articles[0].date unless articles.empty?
  end 

  def isTodaysFeed?
    if !articles.empty?
      feed_date = articles[0].date 
      todays_date = Date.today.strftime("%B %d, %Y") 
      return feed_date == todays_date
    end
    false
  end

  def updateFeed
    if !self.isTodaysFeed? && !isFeedUpdated?
      articles.clear
      articles << self.parse_articles
      save
    end
  end

  def setArticles
    if articles.empty? 
       articles << parse_articles
    end 
  end 
  
  def parse_articles
    data = open(url)
    feed = RSS::Parser.parse(data, false)
    self[:name] = feed.channel.title
    feed.channel.items.collect do | item |
          parse_description = Nokogiri::HTML(item.description).css("body").text
          item_date = item.date
          item_date = DateTime.now if item_date.nil?
          new_article = Article.create(title: item.title, description: parse_description ,  link: item.link, date: item_date.strftime("%B %d, %Y") )
          new_article
    end
  end

end

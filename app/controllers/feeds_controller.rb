class FeedsController < ApplicationController

    def index
        @feeds = getLoggedUser.feeds
    end 

    def show
        @feed = Feed.find(params[:id])
        @articles = @feed.articles 
        @articlesByDate = {}
        date = DateTime.now 
        i = 0
        while i < 7 do
            date = (DateTime.now - i).strftime("%B %d, %Y")
            queriedArticles = Article.where(date: date)
            if date ==  (DateTime.now).strftime("%B %d, %Y")
                date = "Today"
            else    
                date = (DateTime.now - i).strftime("%A %B %d, %Y")
            end
            @articlesByDate[date] = queriedArticles unless queriedArticles.nil?
            i += 1
        end
    end 

    def edit 
        @feed = Feed.find(params[:id])
        @articles = @feed.articles 
        @articlesByDate = Hash.new
        date = DateTime.now 
        i = 0 
        while i < 7 do
            date = (DateTime.now - i).strftime("%B %d, %Y")
            queriedArticles = Article.where(date: date).select(:title, :description)
            if date ==  (DateTime.now).strftime("%B %d, %Y")
                date = "Today"
            else    
                date = (DateTime.now - i).strftime("%A %B %d, %Y")
            end
            @articlesByDate[date] = queriedArticles unless queriedArticles.nil?
            i += 1
        end
    end 
    
    ### Get Requests 

    # get '/edit_feeds' do
    #   @current_user = User.getLoggedUser(session[:id])
    #   if !@current_user.nil?
    #     @feeds = @current_user.feeds ;
    #     erb :edit_feeds
    #   else
    #     flash[:message] = "You are not logged in."
    #     redirect '/login'
    #   end
    # end

    # get '/feeds/:id' do
    #   # The feeds page.
    #   # Future update: Allow the user to view all articles in all feeds by the endless page.. functionality thing. ****** DELETE
    #   @current_user = User.getLoggedUser(session[:id])
    #   if !@current_user.nil?
    #    if !@current_user.feeds.empty?
    #     @current_user.updateFeeds
    #     @current_feed = Feed.find_by(id: params[:id]) if !@current_user.feeds.empty?
    #     @feeds = @current_user.feeds
    #     @current_user.feeds.empty? ? @articles = [] : @articles = @current_feed.articles;
    #     # @feeds.each do | feed |
    #     #   item = {:name => feed.name, :articles => [feed.articles[0], feed.articles[1] ] }
    #     #   @articles << item
    #     # end
    #       erb :view_feeds
    #     else
    #       flash[:message] = "Your feed is empty!\n\nAdd a feed below!"
    #       redirect '/'
    #     end
    #   else
    #     flash[:message] = "You are not logged in."
    #     redirect '/login'
    #   end
    # end

    ### post/patch requests 

    # post '/get_feed/:id' do
    #   redirect "/feeds/#{params[:id]}"
    # end


    #   patch '/process_feeds' do
    #     # Processes feeds by saving each article as an article object and assigning it to a Feed object.
    #     # The feed is then assigned to the user.
    #     # NOTE: A user can have multiple feeds and feeds can have multiple users.
    #     # An article can only have ONE FEED
    #     url = params[:feed]
    #     added_user_feed = Feed.find_by(url: url)
    #     if added_user_feed.nil?
    #       added_user_feed = Feed.create(url: url)
    #       added_user_feed.articles << added_user_feed.parse_articles
    #     else
    #         added_user_feed.updateFeed
    #      end
    #     added_user_feed.save
    #     user = User.find_by(id: session[:id])
    #      if !user.feeds.include?(added_user_feed)
    #        user.feeds << added_user_feed
    #         user.save
    #      else
    #        flash[:message] = "#{added_user_feed.name} is already in your feeds."
    #      end
    #      last_feed = added_user_feed.id
    #      redirect "/feeds/#{last_feed}"
    #   end

    #   delete '/remove_feeds' do
    def destroy
        # Removes a certain feed from the user's feed list.
        @feed_name = Feed.find(params[:id]).name
        getLoggedUser.feeds.delete(params[:id])
        flash[:alert] = "#{@feed_name} has been deleted."
        redirect_to "/"
      end

     ## patch '/add_feed' do
    def create 
        url = params[:feed_url]
        added_user_feed = Feed.find_by(url: url)
        unless added_user_feed
          added_user_feed = Feed.create(url: url)
          added_user_feed.setArticles
        else
            added_user_feed.updateFeed
        end

        added_user_feed.save
        
        user = getLoggedUser
        if !user.feeds.include?(added_user_feed)
           user.feeds << added_user_feed
           user.save
        else
          flash[:alert] = "#{added_user_feed.name} is already in your feeds."
        end
        last_feed = added_user_feed.id
        
         redirect_to "/"
    end

end

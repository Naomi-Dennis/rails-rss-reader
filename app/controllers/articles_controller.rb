class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @article.update(read: true)
        redirect_to @article.link
    end 
end

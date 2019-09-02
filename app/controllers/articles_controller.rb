class ArticlesController < ApplicationController

	before_action :init_user

	def index
		@user = current_user
		@articles = @user.articles.all
	end

	def new
		@article = @user.articles.new
	end

	def create
		@article = @user.articles.create(check_params)
		redirect_to user_articles_path
	end

	def edit
		@article = @user.articles.find(params[:id])
	end
	def update
		@article = @user.articles.find(params[:id])

        if @article.update(check_params)
            redirect_to '/'
        else
            render 'edit'
        end
	end

	def destroy
		@article = @user.articles.find(params[:id])
		@article.destroy
		redirect_to '/'
	end

	private

	def init_user
		@user = current_user
	end

	def check_params
		params.require(:article).permit(:title, :body)
	end
end

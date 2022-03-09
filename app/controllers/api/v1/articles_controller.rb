class Api::V1::ArticlesController < ApplicationController
  before_action :article, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_current_user, only: %i[edit update destroy]


  def index
    @articles = Article.all.order('created_at DESC')
    render json: @articles
  end

  def show
    render json: @article
  end

  def create
    @article = Article.create!(article_params.merge(user: current_user))
    if @article.save
      render json: @article
    else
      render error: { error: 'Unable to create article.' }, status: 400
    end
  end

  def update
    if @article
      @article.update(article_params)
      render json: { message: 'Article successfully updated.' }, status: 200
    else
      render json: { error: 'Unable to update article.' }, status: 400
    end
  end

  def destroy
    begin
      @article = current_user.articles.find(params[:id])
      @article.destroy
      render json: { message: 'Article successfully deleted.' }, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Unable to delete article.' }, status: 400
    end
  end
  
  private

  def set_current_user
    @article = current_user.article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :user_id)
  end

  def article
    @article ||= Article.find(params[:id])
  end
end

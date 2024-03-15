class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render error: { error: 'Unable to create comment.' }, status: :bad_request
    end
  end
  
  def index
    @comments = Comment.all
  end

  def destroy
    begin
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      render json: { message: 'Comment successfully deleted.' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Unable to delete comment.' }, status: :bad_request
    end
  end


  private

  def comment_params
    params.permit(:body, :user_id, :article_id)
  end
end

class MembersOnlyArticlesController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # def index
  #   articles = Article.where(is_member_only: true).includes(:user).order(created_at: :desc)
  #   render json: articles, each_serializer: ArticleListSerializer
  # end

  # def show
  #   article = Article.find(params[:id])
  #   render json: article
  # end

  # private

  # def record_not_found
  #   render json: { error: "Article not found" }, status: :not_found
  # end
  before_action :authorize
  
  def show
    document = Document.find(params[:id])
    render json: document
  end

  def index
    documents = Document.all
    render json: documents
  end

  def create
    document = Document.create(author_id: session[:user_id])
    render json: document, status: :created
  end

  private

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end
end
